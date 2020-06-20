#!/bin/bash
# This script gets the latest GitHub releases for the specified projects.

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

get_latest() {
	local repo=$1

	local resp
	resp=$(curl -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" "${URI}/repos/${repo}/releases")
	local tag
	tag=$(echo "$resp" | jq -e --raw-output .[0].tag_name)
	local name
	name=$(echo "$resp" | jq -e --raw-output .[0].name)

	if [[ "$tag" == "null" ]]; then
		# get the latest tag
		resp=$(curl -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" "${URI}/repos/${repo}/tags")
		tag=$(echo "$resp" | jq -e --raw-output .[0].name)
		tag=${tag#release-}
	fi

	if [[ "$name" == "null" ]] || [[ "$name" == "" ]]; then
		name="-"
	fi

	local dir=${repo#*/}

	# Change to upper case for grep
	local udir
	udir=$(echo $dir | awk '{print toupper($0)}')
	# Replace dashes (-) with underscores (_)
	udir=${udir//-/_}
	udir=${udir%/*}

	if [[ "$dir" == "wireguard-tools" ]]; then
		dir="wireguard/install"
		udir="WIREGUARD_TOOLS"
	elif [[ "$dir" == "wireguard-linux-compat" ]]; then
		dir="wireguard/install"
		udir="WIREGUARD"
	fi

	local current
	if [[ ! -d "$dir" ]]; then
		# If the directory does not exist, then grep all for it
		current=$(grep -m 1 "${udir}_VERSION" -- **/Dockerfile | head -n 1 | awk '{print $(NF)}')
	else
		current=$(grep -m 1 "${udir}_VERSION" "${dir}/Dockerfile" | awk '{print $(NF)}')
	fi


	compare "$name" "$dir" "$tag" "$current" "https://github.com/${repo}/releases"
}

get_latest_unifi() {
	local latest current
	latest=$(curl -sSL http://www.ubnt.com/downloads/unifi/debian/dists/cloudkey-stable/ubiquiti/binary-armhf/Packages \
		| awk 'BEGIN {FS="\n"; RS="";} /^Package: unifi/' \
		| awk '/^Version:/ {print $2}' \
		| cut -d- -f1)

	current=$(grep -m 1 UNIFI_VERSION unifi/Dockerfile | tr '"' ' ' | awk '{print $(NF)}')

	compare unifi unifi "$latest" "$current" https://www.ubnt.com/download/unifi
}

compare() {
	local name="$1" dir="$2" tag="$3" current="$4" releases="$5"
	ignore_dirs=( "mc" "zookeeper/3.6" )

	if [[ "$tag" =~ $current ]] || [[ "$name" =~ $current ]] || [[ "$current" =~ $tag ]] || [[ "$current" == "master" ]]; then
		echo -e "\\e[36m${dir}:\\e[39m current ${current} | ${tag} | ${name}"
	else
		# add to the bad versions
		if [[ ! " ${ignore_dirs[*]} " =~  ${dir}  ]]; then
			bad_versions+=( "${dir}" )
		fi
		echo -e "\\e[31m${dir}:\\e[39m current ${current} | ${tag} | ${name} | ${releases}"
	fi
}

projects=(
	iovisor/bcc
	iovisor/bpftrace
	certbot/certbot
	cloudflare/cfssl
	quay/clair
	hashicorp/consul
	coredns/coredns
	curl/curl
	kolide/fleet
	google/gitiles
	google/guetzli
	irssi/irssi
	cryptodotis/irssi-otr
	keepassxreboot/keepassxc
	robertdavidgraham/masscan
	MidnightCommander/mc
	zyedidia/micro
	mitmproxy/mitmproxy
	hashicorp/nomad
	nzbget/nzbget
	pusher/oauth2_proxy
	facebook/osquery
	hashicorp/packer
	Tautulli/Tautulli
	perkeep/perkeep
	pomerium/pomerium
	powershell/powershell
	cesanta/docker_auth
	ricochet-im/ricochet
	rstudio/rstudio
	tarsnap/tarsnap
	maxmind/libmaxminddb
	hashicorp/terraform
	kdlucas/byte-unixbench
	mitchellh/vagrant
	hashicorp/vault
	containrrr/watchtower
	wireguard/wireguard-tools
	wireguard/wireguard-linux-compat
	znc/znc
	tianon/gosu
)

other_projects=(
	unifi
)

bad_versions=()

main() {
	# shellcheck disable=SC2068
	for p in ${projects[@]}; do
		get_latest "$p"
	done
	# shellcheck disable=SC2068
	for p in ${other_projects[@]}; do
		get_latest_"$p"
	done

	if [[ ${#bad_versions[@]} -ne 0 ]]; then
		echo
		echo "These Dockerfiles are not up to date: ${bad_versions[*]}" >&2
		exit 1
	fi
}

main

FROM golang:alpine as builder
LABEL maintainer "Matt Kozak <matt@mkozak.pl>"

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go

RUN	apk add --no-cache \
	bash \
	ca-certificates \
	gcc \
	git \
	make \
	zip

ENV PACKER_VERSION v1.8.5

RUN go install github.com/hashicorp/packer@${PACKER_VERSION}

WORKDIR /go/src/github.com/hashicorp/packer

RUN git checkout "${PACKER_VERSION}"

RUN XC_ARCH="amd64" XC_OS="linux" LD_FLAGS=" -extldflags -static" make releasebin \
	&& mv bin/packer /usr/bin/packer

FROM alpine:latest

RUN apk add --no-cache \
	bash \
	tar

COPY --from=builder /usr/bin/packer /usr/bin/packer
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs

ENTRYPOINT [ "packer" ]
CMD [ "--help" ]

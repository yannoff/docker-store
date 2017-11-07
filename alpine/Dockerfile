# vim: ft=Dockerfile
#
# @package alpine
# @author  yannoff <https://github.com/yannoff>
# @license MIT
#

FROM alpine:latest
MAINTAINER Yannoff <https://github.com/yannoff>

RUN \
    apk --update --no-cache add bash;

COPY keep-alive /usr/local/bin/keep-alive
RUN ln -s /usr/local/bin/keep-alive /

ENTRYPOINT ["/keep-alive"]

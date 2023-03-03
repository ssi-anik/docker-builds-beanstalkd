FROM alpine as builder
RUN apk add --no-cache build-base git
COPY . /tmp/beanstalkd
RUN cd /tmp/beanstalkd && make

################################

FROM alpine

COPY --from=builder /tmp/beanstalkd/beanstalkd /usr/bin/

VOLUME "/binlog"

EXPOSE 11300

CMD ["/usr/bin/beanstalkd", "-p", "11300", "-b", "/binlog"]

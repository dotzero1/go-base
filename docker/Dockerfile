# This is the base image that will run the final binary
FROM alpine:latest

RUN apk --no-cache add curl bash

COPY wrapper.sh /usr/wrapper.sh
RUN chmod +x /usr/wrapper.sh

WORKDIR /usr

ENTRYPOINT ["/usr/wrapper.sh"]

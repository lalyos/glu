FROM alpine:3.2
ENV GLU_CONTAINER true
ENTRYPOINT ["/bin/cat"]
CMD ["Linux"]

RUN apk --update add curl ca-certificates git mercurial bash && \
    curl -Ls https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk > /tmp/glibc-2.21-r2.apk && \
    apk add --allow-untrusted /tmp/glibc-2.21-r2.apk && \
    curl -Ls https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz > /usr/local/go1.5.linux-amd64.tar.gz && \
    cd /usr/local && \
    tar -zxf go1.5.linux-amd64.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    rm -rf /tmp/glibc-2.21-r2.apk /usr/local/go1.5.linux-amd64.tar.gz /var/cache/apk/*

COPY ./build /build
RUN cp /build/Linux/glu /bin/glu \
  && tar -cf /Darwin -C /build/Darwin glu \
  && tar -cf /Linux -C /build/Linux glu \
  && rm -rf /build

FROM haskell:8.6.3
LABEL maintainer "Dongri Jin <dongrify@gmail.com>"

ENV APP_ROOT /root/src
ADD . $APP_ROOT
WORKDIR $APP_ROOT/web

RUN stack setup
RUN stack --system-ghc --local-bin-path /sbin build

RUN cp /root/src/web/.stack-work/install/x86_64-linux/lts-13.16/8.6.4/bin/web /sbin/

EXPOSE 3000
CMD ["/sbin/web"]

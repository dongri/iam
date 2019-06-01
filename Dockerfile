FROM haskell:8.6.3
LABEL maintainer "Dongri Jin <dongrify@gmail.com>"

ENV APP_ROOT /root/src
ADD . $APP_ROOT
WORKDIR $APP_ROOT/web

RUN stack setup
RUN stack --system-ghc --local-bin-path /sbin build -j 1
#  --no-terminal , --only-dependencies -j 1 (herokuでout of memory発生で並列ビルドを抑制)

RUN cp /root/src/web/.stack-work/install/x86_64-linux/lts-13.16/8.6.4/bin/web /sbin/

EXPOSE 3001
CMD ["/sbin/web"]

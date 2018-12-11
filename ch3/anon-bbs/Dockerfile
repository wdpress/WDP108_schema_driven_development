FROM ruby:2.5.3

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    APP_HOME=/usr/src/app
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
    BUNDLE_JOBS=4

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

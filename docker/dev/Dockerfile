FROM ruby:3.4.3-alpine

WORKDIR /app

# Install packages needed to build gems
RUN apk add --no-cache \
    build-base \
    git \
    vips-dev \
    pkgconfig \
    bash \
    yaml-dev \
    libffi-dev \
    readline-dev \
    zlib-dev \
    openssl-dev \
    tzdata \
    vim \
    nano

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

COPY docker/dev/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

RUN echo 'PS1="\[\e[38;5;76m\]Vaults\[\e[m\]\[\e[38;5;15m\] : \[\e[m\]\[\e[38;5;250m\]\w\[\e[m\]\[\e[38;5;231m\] λ \[\e[m\]"' >> ~/.bashrc

CMD ["rails", "server", "-b", "0.0.0.0"]
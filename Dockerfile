FROM elixir:latest

# Adicionando pacotes básicos
RUN apt-get update
RUN apt-get install -y postgresql-client ncurses-dev imagemagick libc-dev openssh-server git gcc inotify-tools nodejs
RUN curl -L https://npmjs.org/install.sh | sh

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new 1.5.7 --force

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY . /app

RUN mix deps.get
RUN mix deps.compile
RUN mix do compile

CMD ["/app/entrypoint.sh"]
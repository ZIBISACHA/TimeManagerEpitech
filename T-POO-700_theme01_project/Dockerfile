FROM elixir:latest

RUN apt-get update && \ 
        apt-get install -y inotify-tools && \
        apt-get install -y postgresql-client

RUN mkdir /T-POO-700_theme01_project
COPY . /T-POO-700_theme01_project
WORKDIR /T-POO-700_theme01_project

RUN mix local.hex --force
# RUN mix deps.clean --all
RUN mix deps.get
RUN mix local.rebar --force
RUN mix do compile

CMD ["/T-POO-700_theme01_project/entrypoint.sh"]

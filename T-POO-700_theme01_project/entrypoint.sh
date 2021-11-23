#!/usr/bin/env bash

if [ -f ".env" ]; then
    echo "$FILE exists."
else
    echo "$FILE does not exist."
    exit 1
fi

while ! pg_isready -q -h $PGHOST -p $PGPORT --username=$PGUSER
do
  sleep 2
done

if [[ -z `psql -qc "\\l $PGDATABASE"` ]]; then
  createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  echo "The database $PGDATABASE has been created."
fi

exec mix phx.server
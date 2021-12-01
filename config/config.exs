import Config

config :aoc,
  cookie: "session=asd"

import_config("#{Mix.env()}.exs")

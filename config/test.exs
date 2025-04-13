import Config

config :my_chat, MyChatWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "2ou1dbz8rAWYEvnJlHvMC+j8U+CSd3dYlWoKqLyrOCxIF4379fFiNQCHWaQK3k3Z",
  server: false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  enable_expensive_runtime_checks: true

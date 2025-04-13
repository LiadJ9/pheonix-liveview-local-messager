defmodule MyChat.Weather.Api do
  @callback today(location :: String.t()) :: {:ok, MyChat.Weather.t()} | {:error, term()}
end

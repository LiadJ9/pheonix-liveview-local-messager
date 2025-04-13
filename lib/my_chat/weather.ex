defmodule MyChat.Weather do
  @type precipitation() :: %{
          type: :snow | :rain | :sleet | :hail,
          chance: number()
        }

  @type t() :: %__MODULE__{
          id: Ecto.UUID.t(),
          temperature: number(),
          units: :fahrenheit | :celsius,
          precipitation: precipitation() | nil,
          location: String.t(),
        }

  defstruct [:id, :temperature, :units, :precipitation, :location]
end

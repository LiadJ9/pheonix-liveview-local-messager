defmodule MyChat.Time do

  @type t() :: %__MODULE__{
          id: Ecto.UUID.t(),
          date: DateTime.t(),
        }

  defstruct [:id, :date]

  def new_time(date) do
    %__MODULE__{
      id: Ecto.UUID.generate(),
      date: date
    }
  end
end

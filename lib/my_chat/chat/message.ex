defmodule MyChat.Chat.Message do
  alias MyChat.Chat.Message
  alias MyChat.Chat.Categorizer, as: Categorizer

  @type uncategorized() :: %__MODULE__{
          id: Ecto.UUID.t(),
          category: nil,
          content: String.t(),
          date: DateTime.t(),
        }

  @type t() :: %__MODULE__{
          id: Ecto.UUID.t(),
          category: :engineering | :product | :sales | :marketing,
          content: String.t(),
          date: DateTime.t(),
        }
  defstruct [:id, :category, :content, :date]


  @spec new_msg(String.t(), DateTime.t()) :: Message.t()
  def new_msg(content, date) do
    msg = %__MODULE__{
      id: Ecto.UUID.generate(),
      category: nil,
      content: content,
      date: date
    }
    Categorizer.categorize(msg)
  end

  @spec message_color(:engineering | :product | :sales | :marketing) :: String.t()
  def message_color(category) do
    Categorizer.category_to_color(category) |> Categorizer.color_to_tailwind_class
  end


end

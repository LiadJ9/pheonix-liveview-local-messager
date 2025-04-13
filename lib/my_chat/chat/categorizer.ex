defmodule MyChat.Chat.Categorizer do
  @spec categorize(MyChat.Chat.Message.uncategorized()) :: MyChat.Chat.Message.t()
  def categorize(%MyChat.Chat.Message{category: nil} = message) do
    %{message | category: Enum.random([:engineering, :product, :sales, :marketing])}
  end

  @spec category_to_color(:engineering | :marketing | :product | :sales) ::
          :blue | :green | :red | :yellow
  def category_to_color(:engineering), do: :blue
  def category_to_color(:product), do: :green
  def category_to_color(:sales), do: :red
  def category_to_color(:marketing), do: :yellow


  # I really don't like this.
  #I've tried using string interpolation (using "border-" <> color <> "-500") but tailwind didn't pick it up.

  @spec color_to_tailwind_class(:blue | :green | :red | :yellow) :: String.t()
  def color_to_tailwind_class(:blue), do: "border-blue-500"
  def color_to_tailwind_class(:green), do: "border-green-500"
  def color_to_tailwind_class(:red), do: "border-red-500"
  def color_to_tailwind_class(:yellow), do: "border-yellow-500"
end

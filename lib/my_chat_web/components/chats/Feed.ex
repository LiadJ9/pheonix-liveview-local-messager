defmodule Feed do
  use Phoenix.Component
  alias Phoenix.LiveView.Rendered

  @spec feedList(feed_items: Enumerable.t()) :: Rendered.t()
  def feedList(assigns) do
    ~H"""
    <div class="flex flex-col gap-2 w-full h-full overflow-y-auto" id="feed_items" phx-update="stream">
      <%= for {id, data} <- @feed_items do %>
       <div id={id}>
        <Messages.message data={data} />
       </div>
      <% end %>
    </div>
    """
  end

  # I tried to handle the "update_text" event Here because it seems fundementally right for it to be here,
  # but I just couldn't get it to work without re-rendering every trigger.

  @spec chatBar(new_message: String.t(), weather_error: String.t()) :: Rendered.t()
  def chatBar(assigns) do
    ~H"""
      <div class="flex flex-col absolute bottom-0 gap-0 w-full">
      <%= if @weather_error do %>
      <div class="absolute bottom-0 px-6 text-red-400 font-bold">
        {@weather_error}
      </div>
      <% end %>
      <form class=" flex flex-row w-full p-6 mr-2" phx-submit="submit_message">
        <Fields.textfield name="new-message" phx_change="update_text" value={@new_message} placeholder="New Message..." />
        <button class="flex flex-row p-2 justify-center align-center bg-white text-blue-500 rounded-full transition hover:bg-gray-300">
        <Heroicons.icon name="paper-airplane" class="h-6 w-6"  />
        </button>
      </form>
      </div>
    """
  end

end

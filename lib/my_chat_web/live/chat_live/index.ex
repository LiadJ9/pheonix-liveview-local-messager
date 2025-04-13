defmodule MyChatWeb.ChatLive.Index do
  use MyChatWeb, :live_view
  alias MyChat.Time
  alias MyChat.Publisher
  alias MyChat.Chat.Message
  alias MyChat.Weather

  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> set_message("")
    |> assign(weather_error: nil)
    |> assign(chat_id: nil)
    |> stream(:feed_items, [])}
  end

  # I wanted to put these handler functions in appropriate modules for organization,
  # but I wasn't sure how to use assign outside of this module/best practice and I didn't want to pass it around. /:
  @spec set_message(Pheonix.LiveView.Socket.t(), String.t()) :: Pheonix.LiveView.Socket.t()
  def set_message(socket, message) do
    assign(socket, new_message: message)
  end


  @spec handle_weather(String.t(), Pheonix.LiveView.Socket.t()) :: {:noreply, Pheonix.LiveView.Socket.t()}
  def handle_weather(msg, socket) do
    location = String.replace(msg, "/weather ", "")
    res = Weather.Service.today(location)
    case res do
      {:ok, weather} ->
        {:noreply, socket |> set_message("") |> assign(weather_error: nil) |> stream_insert(:feed_items, weather, at: -1)}

      {:error, error} ->
        {:noreply, socket |> assign(weather_error: error)}
    end
  end

  @spec handle_clock(Pheonix.LiveView.Socket.t()) :: {:noreply, Pheonix.LiveView.Socket.t()}
  def handle_clock(socket) do
    date = Time.new_time(DateTime.utc_now())
    {:noreply, socket |> set_message("") |> assign(weather_error: nil) |> stream_insert(:feed_items, date, at: -1)}
  end

  def handle_params(_params, _uri, %{assigns: %{live_action: :initializing}} = socket) do
    {:noreply, socket |> push_patch(to: ~p"/chat/#{Ecto.UUID.generate()}")}
  end

  def handle_params(%{"id" => chat_id}, _uri, %{assigns: %{live_action: :chat}} = socket) do
    Phoenix.PubSub.subscribe(MyChat.PubSub, "feed_#{chat_id}")
    {:noreply, socket |> assign(chat_id: chat_id)}
  end

  def handle_info(:tick, socket) do
    {:noreply, assign(socket, current_time: DateTime.utc_now())}
  end

  def handle_info({:message, message}, socket) do
    {:noreply, stream_insert(socket, :feed_items, message, at: -1)}
  end

  def handle_event("update_text", %{"new-message" => new_message}, socket) do
    {:noreply, socket |> set_message(new_message)}
  end

  def handle_event("submit_message", _value, socket) do
    message = socket.assigns.new_message
    lower_message = String.downcase(message)
    cond do
      String.contains?(lower_message, "/weather") ->
        handle_weather(lower_message, socket)
      String.contains?(lower_message, "/clock") ->
        handle_clock(socket)
      lower_message == "" ->
        {:noreply, socket}
      true ->
        message = Message.new_msg(message, DateTime.utc_now())
        Publisher.publish_message(message, socket.assigns.chat_id)
        {:noreply, socket |> set_message("") |> assign(weather_error: nil)}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col relative h-full bg-neutral-100 rounded-xl shadow-xl items items-center">
      <div class="flex flex-col h-[90%] p-4 w-full">
      <Feed.feedList feed_items={@streams.feed_items}/>
      </div>
      <Feed.chatBar weather_error={@weather_error} new_message={@new_message} />
    </div>
    """
  end
end

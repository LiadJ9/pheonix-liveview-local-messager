defmodule Messages do
  use Phoenix.Component
  alias MyChat.Chat.Message
  alias MyChat.Weather
  alias MyChat.Time

  def message(%{data: %Message{}} = assigns) do
    ~H"""
    <.single message={@data} />
    """
  end

  def message(%{data: %Weather{}} = assigns) do
    ~H"""
    <.weather weather={@data} />
    """
  end

  def message(%{data: %Time{}} = assigns) do
    ~H"""
    <.time time={@data} />
    """
  end

  @spec single(message: Message.t()) :: Phoenix.LiveView.Rendered.t()
  def single(assigns) do
    ~H"""
    <div    class={[
            "message-box",
            Message.message_color(@message.category)
          ]}  >
      <div class="font-bold"><%= @message.category %></div>
      <div>{@message.content}</div>
      <div><%= Calendar.strftime(@message.date, "%Y-%m-%d %H:%M") %></div>
    </div>
    """
  end

  @spec weather(weather: Weather.t()) :: Phoenix.LiveView.Rendered.t()
  def weather(assigns) do
    ~H"""
    <div class="message-box border-purple-500">
      <div><span class="font-bold">Location:</span> {@weather.location}</div>
      <div><span class="font-bold">Temp:</span> {@weather.temperature}</div>
      <div><span class="font-bold">Units:</span> {@weather.units}</div>
      <%= if @weather.precipitation do %>
      <div>
        <span class="font-bold">Precipitation:</span>
        {@weather.precipitation.type} {@weather.precipitation.chance}

      </div>
      <% end %>
    </div>
    """
  end

  @spec time(time: Time.t()) :: Phoenix.LiveView.Rendered.t()
  def time(assigns) do
    ~H"""
    <div class="message-box border-rose-500" >
    <span class="font-bold">Current Time:</span>
    <div id={@time.id}  phx-hook="ClockHook"/>
    </div>
    """
  end


end

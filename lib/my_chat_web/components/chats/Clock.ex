defmodule Clock do
  use Phoenix.LiveComponent

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  # I had a hard time getting this to work and I just settled for a javascript solution. /:

  #Two clock versions exists so you can see that I do have a basic understanding of live components.

  # The general idea I had here was to use a handle_info here so each clock component would handle it's own ticking,
  # but then I realized live components could not use handle_info...
  # So what I did was just "fake" each clock having it's own timer
  # and just update a single variable every second (assign(current_time: DateTime.utc_now()))
  # This completely backfired on me once i realized streams causes it so the values passed through them
  # don't necessarily update unless I directly update the item in the stream (one of the clock task requirements).

  def render(assigns) do
    ~H"""
    <div id={@id}  class="message-box border-rose-500" >
    {Calendar.strftime(@current_time, "%H:%M:%S") }
    I'm not part of the stream!
    </div>
    """
  end

end

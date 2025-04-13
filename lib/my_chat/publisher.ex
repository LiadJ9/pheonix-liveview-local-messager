defmodule MyChat.Publisher do

    alias MyChat.Chat.Message


    @spec publish_message(Message.t(), Ecto.UUID.t()) :: :ok
    def publish_message(msg, feed_id) do
      Phoenix.PubSub.broadcast(MyChat.PubSub, "feed_#{feed_id}", {:message,msg})
    end

end

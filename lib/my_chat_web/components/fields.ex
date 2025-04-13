defmodule Fields do
  use Phoenix.Component

  @spec textfield(name: String.t(), phx_change: String.t(), value: String.t(), placeholder: String.t()) :: Phoenix.LiveView.Rendered.t()
  def textfield(assigns) do
      ~H"""
      <input type="text" name={@name} value={@value} phx-change={@phx_change} placeholder={@placeholder}  class="w-full rounded-full px-4 py-2 mr-2" />
      """
  end
end

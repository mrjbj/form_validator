defmodule FormValidatorWeb.Components.Dialog do
  use Surface.LiveComponent

  @moduledoc """
  Statelful Modal Dialog. (e.g. LiveComponent)
  Implements default behavior for "close" event, that can be overridden by caller through
  "close_click" property if needed.
  (For example, coding in an "are your sure?" check before closing)
  "ok_click defaults to close as well"
  """
  alias FormValidatorWeb.Components.MyButton

  prop title, :string, required: true
  prop ok_label, :string, default: "Ok"
  prop close_label, :string, default: "Close"
  prop ok_click, :event, default: "close"
  prop close_click, :event, default: "close"

  @doc "should dialog form be visible? set true on open"
  data show, :boolean, default: false

  slot default

  def render(assigns) do
    ~F"""
    <div class={"modal", "is-active": @show} :on-window-keydown={@close_click} phx-key="Escape">
      <div class="modal-background" />
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">{@title}</p>
        </header>
        <section class="modal-card-body">
          <#slot />
        </section>
        <footer class="modal-card-foot" style="justify-content: flex-end">
          <MyButton click={@ok_click}>{@ok_label}</MyButton>
          <MyButton click={@close_click} kind="is-danger">{@close_label}</MyButton>
        </footer>
      </div>
    </div>
    """
  end

  # Public API

  def open(dialog_id) do
    send_update(__MODULE__, id: dialog_id, show: true)
  end

  def close(dialog_id) do
    send_update(__MODULE__, id: dialog_id, show: false)
  end

  # Default event handlers

  def handle_event("close", _, socket) do
    {:noreply, assign(socket, show: false)}
  end
end

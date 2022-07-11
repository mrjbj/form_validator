defmodule FormValidatorWeb.Components.Dialog.Example01 do
  use Surface.Catalogue.Example,
    subject: FormValidatorWeb.Components.Dialog,
    height: "480px",
    title: "Name & Subtitle"

  alias FormValidatorWeb.Components.MyButton
  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput, Label, Field}


  def render(assigns) do
    ~F"""
    <div>
      <Dialog title="User form" id="form_dialog_2">
        <Form for={:user}>
          <Field name="name"><Label/><TextInput/></Field>
          <Field name="email"><Label/><TextInput/></Field>
        </Form>
        Clicking <strong>"Ok"</strong> or <strong>"Close"</strong>
        closes the form (default behaviour).
      </Dialog>

      <MyButton click="open_form">Click to open the dialog!</MyButton>
    </div>
    """
  end

  def handle_event("open_form", _, socket) do
    Dialog.open("form_dialog_1")
    {:noreply, socket}
  end
end

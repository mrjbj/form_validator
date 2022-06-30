defmodule FormValidator.Registry do
  use Ash.Registry, extensions: [Ash.Registry.ResourceValidations]

  entries do
    entry FormValidator.User
    entry FormValidator.Address
  end
end

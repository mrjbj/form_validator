defmodule FormValidator.Api do
  use Ash.Api

  resources do
    registry FormValidator.Registry
  end
end

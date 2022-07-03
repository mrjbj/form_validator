defmodule FormValidator.Address do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  postgres do
    repo FormValidator.Repo
    table "addresses"
  end

  attributes do
    uuid_primary_key :id

    attribute :user_id, :uuid, allow_nil?: false
    attribute :number, :integer, allow_nil?: true
    attribute :street, :string, allow_nil?: true
    attribute :city, :string, allow_nil?: true
    attribute :state, :string, allow_nil?: true
    attribute :postal_code, :string, allow_nil?: true

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :user, FormValidator.User,
      source_field: :user_id,
      destination_field: :id,
      description: "Each address belongs to one User."
  end

  actions do
    create :create, primary?: true
    read :read, primary?: true
    update :update, primary?: true
    destroy :destroy, primary?: true
  end
end

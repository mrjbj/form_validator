defmodule FormValidator.Tweet do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  postgres do
    repo FormValidator.Repo
    table "tweets"
  end

  identities do
    identity :body, [:body]
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    attribute :body, :string do
      allow_nil? false
      constraints max_length: 255
    end

    attribute :public, :boolean, allow_nil?: false, default: false
    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :user, FormValidator.User
  end
end

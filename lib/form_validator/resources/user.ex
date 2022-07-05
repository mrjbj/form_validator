defmodule FormValidator.User do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  postgres do
    repo FormValidator.Repo
    table "users"
  end

  identities do
    identity :email, [:email]
  end

  attributes do
    uuid_primary_key :id

    attribute :email, :string, allow_nil?: false, constraints: [max_length: 255]

    attribute :username, :string,
      allow_nil?: false,
      default: "changeme",
      constraints: [min_length: 5, max_length: 30]

    attribute :password, :string,
      allow_nil?: false,
      default: "Goober4,123",
      constraints: [min_length: 6, max_length: 80]

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :tweets, FormValidator.Tweet do
      source_field :id
      destination_field :user_id
      description "Each user can have many tweets."
      violation_message "Can't delete User when Tweets are found."
    end

    has_many :addresses, FormValidator.Address do
      source_field :id
      destination_field :user_id
      description "Each user can have many addresses."
      violation_message "Can't delete User when Address is found."
    end
  end

  actions do
    # default
    defaults [:create, :read, :update, :destroy]
    # custom
    create :validate

    update :add_tweets do
      argument :tweets, {:array, :map}, allow_nil?: false
      change manage_relationship(:tweets, type: :create)
    end

    # :on_no_match [:error, :create, :ignore, :match]
    # :on_match [:error, :destroy, :ignore, :no_match, :update, :unrelate]
    # :on_lookup [:ignore, :relate]
    # :on_missing [:destroy, :error, :ignore, :unrelate]
    update :remove_tweets do
      argument :tweets, {:array, :string}
      change manage_relationship(:tweets, on_match: :destroy)
    end

    read :get_by_email do
      argument :email, :string
      filter email: arg(:email)
    end
  end

  validations do
    validate match(
               :email,
               ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i,
               "must have the @ sign and no spaces"
             )

    validate match(
               :username,
               ~r/^[a-zA-Z0-9_.-]*$/,
               "Please use only letters or numbers without spaces (characters _ and - are allowed)"
             )

    validate match(:password, ~r/[a-z]/, "must have at least one lower case character")
    validate match(:password, ~r/[A-Z]/, "must have at least one UPPER case character")

    validate match(
               :password,
               ~r/[!?#$%^&*_0-9]/,
               "must have at least one digit or punctuation character"
             )
  end
end

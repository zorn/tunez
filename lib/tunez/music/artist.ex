defmodule Tunez.Music.Artist do
  use Ash.Resource, otp_app: :tunez, domain: Tunez.Music, data_layer: AshPostgres.DataLayer

  postgres do
    table "artists"
    repo Tunez.Repo
  end

  actions do
    # create :create do
    #   accept [:name, :biography]
    # end

    # read :read do
    #   primary? true
    # end

    update :update do
      # This is needed for the `previous_names` logic, but I'm not sure the real impact. Books says that will be talked about in chapter 10.
      require_atomic? false

      accept [:name, :biography]

      change Tunez.Music.Changes.UpdatePreviousNames, where: [changing(:name)]
    end

    # destroy :destroy do
    # end

    defaults [:create, :read, :destroy]
    default_accept [:name, :biography]
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
    end

    attribute :previous_names, {:array, :string} do
      default []
    end

    attribute :biography, :string

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :albums, Tunez.Music.Album do
      sort year_released: :desc
    end
  end
end

defmodule Tunez.Music do
  use Ash.Domain, otp_app: :tunez, extensions: [AshJsonApi.Domain, AshPhoenix]

  json_api do
    routes do
      base_route "/artists", Tunez.Music.Artist do
        get :read
        index :search
        post :create
        patch :update
        delete :destroy
      end

      base_route "/albums", Tunez.Music.Album do
        post :create
        patch :update
        delete :destroy
      end
    end
  end

  forms do
    form :create_album, args: [:artist_id]
  end

  resources do
    resource Tunez.Music.Artist do
      define :create_artist, action: :create

      # QUESTION: Is there a reason why we choose not `list_artists` to better fall inline with standard generators?
      define :read_artists, action: :read

      define :get_artist_by_id, action: :read, get_by: :id

      define :update_artist, action: :update

      define :destroy_artist, action: :destroy

      define :search_artists,
        action: :search,
        args: [:query],
        default_options: [
          load: [:album_count, :latest_album_year_released, :cover_image_url]
        ]
    end

    resource Tunez.Music.Album do
      define :create_album, action: :create
      define :get_album_by_id, action: :read, get_by: :id
      define :update_album, action: :update
      define :destroy_album, action: :destroy
    end

    resource Tunez.Music.Album
  end
end

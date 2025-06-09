defmodule Tunez.Music do
  use Ash.Domain, otp_app: :tunez, extensions: [AshPhoenix]

  resources do
    resource Tunez.Music.Artist do
      define :create_artist, action: :create

      # QUESTION: Is there a reason why we choose not `list_artists` to better fall inline with standard generators?
      define :read_artists, action: :read

      define :get_artist_by_id, action: :read, get_by: :id

      define :update_artist, action: :update

      define :destroy_artist, action: :destroy
    end
  end
end

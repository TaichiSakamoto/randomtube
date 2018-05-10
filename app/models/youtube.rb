class Youtube < ApplicationRecord
  has_many :videos
  has_many :channels
  has_many :playlists
end

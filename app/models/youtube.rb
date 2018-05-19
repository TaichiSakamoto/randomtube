class Youtube < ApplicationRecord
  has_many :videos
  has_many :channels
end

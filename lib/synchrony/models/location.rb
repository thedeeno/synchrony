module Synchrony
  class Location < ActiveRecord::Base
    has_many :placements
    has_many :containers, through: :placements
  end
end

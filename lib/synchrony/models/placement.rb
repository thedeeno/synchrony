module Synchrony
  class Placement < ActiveRecord::Base
    belongs_to :location
    belongs_to :container, counter_cache: true
  end
end

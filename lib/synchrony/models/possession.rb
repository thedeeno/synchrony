module Synchrony
  class Possession < ActiveRecord::Base
    belongs_to :employee
    belongs_to :container, counter_cache: true
  end
end

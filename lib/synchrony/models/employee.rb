module Synchrony
  class Employee < ActiveRecord::Base
    has_many :possessions
    has_many :containers, through: :possessions

    def self.signed_in
      where(signed_in: true)
    end

    def carrying?
      containers.count > 0
    end

    def dropoff_at(location)
      location.containers += containers
      possessions.destroy_all
    end

    def pickup(container)
      containers << container
    end
  end
end

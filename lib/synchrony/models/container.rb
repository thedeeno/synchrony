module Synchrony
  class Container < ActiveRecord::Base
    has_many :possessions
    has_many :placements

    def held?
      possessions_count > 0
    end

    def placed?
      placements_count > 0
    end

    def free?
      not (held? or placed?)
    end

    def self.free
      where(possessions_count: 0).where(placements_count: 0)
    end

    def self.unorganized
      where(placements_count: 0)
    end

  end
end

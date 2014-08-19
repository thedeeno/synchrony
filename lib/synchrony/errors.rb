module Synchrony
  class BadClassError < StandardError
    def initialize(klass, attempt)
      "Failed to save #{attempt.class}. Only instances of #{klass} are allowed"
    end
  end
end


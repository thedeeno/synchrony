module Synchrony
  # A simple storage mechanism for models with identity
  #
  # It provides an api similar to ActiveRecord
  #
  # Adding a database dependency for this simple project
  # feels like overkill. This should suffice.
  class StorageService

    # resets the index for all instances of StorageService
    def self.reset!
      ObjectSpace.each_object(self) { |x| x.reset }
    end

    attr_accessor :index

    # param klass
    #   the class this storage service expects to store instance of
    def initialize(klass)
      @index = {}
      @klass = klass
    end

    def find(id)
      @index[id] if id
    end

    def save(instance)
      raise BadClassError.new(@klass, instance) unless instance.is_a? @klass
      assign_id(instance)
      @index[instance.id] = instance
    end

    # assigns the next sequential id to object if it doesn't have one
    def assign_id(obj)
      return if obj.id
      obj.id = next_id
      obj
    end

    def all
      @index
    end

    def count
      @index.length
    end

    # clear the backing index
    def reset
      @index = {}
    end

    # calculates the next id for the class
    def next_id
      return 0 if @index.count == 0
      @index.values.map(&:id).max + 1
    end
  end
end



module Synchrony
module Acceptance
  class BrowserSession < Capybara::Session
    def self.create
      self.new(:selenium)
    end

    def initialize(*args)
      super *args
    end

    def focus
      @driver.browser.switch_to.window(current_window.handle)
    end
  end
end
end

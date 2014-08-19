module Synchrony
module Acceptance
  class ManagerAgent
    include RSpec::Matchers

    def browser
      @browser ||= BrowserSession.create
    end

    def open_monitor_app
      browser.visit("http://#{ENV["SYNCHRONY_URI"]}/monitor")
    end

    # asserts that this manager can see the specified number of 
    # elements in graph's svg element
    def see!(selector, count)
      expected = count.to_i
      return true if svg.nil? and expected == 0
      expect(svg).to have_selector(selector, count: expected), see_failure(selector, expected)
    end

    # better error message missing elements
    def see_failure(selector, expected)
      return "svg not found" if svg.nil?
      actual = svg.all(selector).count
      failure_msg = <<-EOS
#{actual} elements matching '#{selector}', expected #{expected}
EOS
      failure_msg
    end

    # Returns the first svg element found on the browser's page
    #
    # Selenium can't find svg elements when using simple xpaths
    # or css selectors because of an xml namespace bug (as far as I
    # can tell) but works this more explicit xpath.
    def svg
      browser.first(:xpath, "//*[local-name() = 'svg']")
    end
  end
end
end

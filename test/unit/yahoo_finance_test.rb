require 'test_helper'

class YahooFinanceTest < ActiveSupport::TestCase
  # These tests are "fragile".  They actually connect to the source.
  # I have done this for TDD purposes, as I am trying to understand
  # the Yahoo Finance interface as I develop.  After completeing the initial 
  # development we could stub out the actual call to Yahoo there by 
  # isolating the tests from connectivity issues.
  

  test "request single symbol" do
    result = YahooFinance.market_details("GOOG")
    assert result.has_value?('Google Inc.')
  end

  test "request invalid symbol" do
    result = YahooFinance.market_details("ZZ123ZZZZ")
    assert !result[:is_valid]
  end

end

require 'test_helper'

class HoldingTest < ActiveSupport::TestCase
  test "symbol is required" do
    holding = Holding.create(price: 100, qty: 100)
    assert_equal ["can't be blank"], holding.errors[:symbol]
  end

  test "price is required" do
    holding = Holding.create(symbol: 'GOOG', qty: 100)
    assert_equal ["can't be blank", "is not a number"], holding.errors[:price]
  end

  test "qty is required" do
    holding = Holding.create(symbol: 'GOOG', price: 100)
    assert_equal ["can't be blank", "is not a number"], holding.errors[:qty]
  end

end

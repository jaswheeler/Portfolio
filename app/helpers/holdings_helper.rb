module HoldingsHelper
  def sum_portfolio
    @holdings.inject(0) {|sum, i| sum + i.gain.to_i }
  end
end

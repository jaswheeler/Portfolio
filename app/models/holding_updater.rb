class HoldingUpdater
  def self.run
    symbols = Holding.all.map { |h| h.symbol }
    YahooFinance.market_details(symbols).each do |holding|
      key = holding.keys.first
      puts Holding.where(symbol: key).inspect
      Holding.where(symbol: key.to_s).each { |h| h.update_attributes(holding[key]) }
    end 
  end
end

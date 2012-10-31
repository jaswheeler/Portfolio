require 'mechanize'
require 'csv'

class YahooFinance
  
  def self.market_details(symbols)
    yf = self.new
    yf.market_details(symbols) 
  end

  def market_details(symbols)
    agent = Mechanize.new
    results = agent.get("http://finance.yahoo.com/d/quotes.csv?s=#{symbol_string(symbols)}&f=snabghn4e1").body
    parse_collection(remove_malformed_csv(results))
  end

  private

  def parse_collection(results)
    records = []
    CSV.parse(results, :headers => false) do |row| 
      valid = row[7].eql?('invalid') ? false : true
      records << {symbol: row[0], 
                  name: row[1], 
                  ask: row[2].to_f, 
                  bid: row[3].to_f, 
                  low: row[4].to_f,
                  high: row[5].to_f,
                  notes: row[6],
                  valid: valid} 
    end
    records
  end

  def symbol_string(symbols)
    symbols.class.eql?(Array) ? symbols.join('+') : symbols
  end

  def remove_malformed_csv(results)
    results.gsub(/No such ticker symbol.+\)/, 'invalid')
  end

end

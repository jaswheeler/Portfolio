require 'mechanize'
require 'csv'

class YahooFinance
  
  def self.market_details(symbol)
    yf = self.new
    yf.market_details(symbol) 
  end

  def market_details(symbol)
    agent = Mechanize.new
    result = agent.get("http://finance.yahoo.com/d/quotes.csv?s=#{symbol}&f=snabghn4e1").body
    parse_collection(remove_malformed_csv(result))
  end

  private

  def parse_collection(results)
    #records = []
    CSV.parse(results, :headers => false) do |row| 
      valid = row[7].eql?('invalid') ? false : true
      #records << { name: row[1], 
      return { name: row[1], 
               ask: row[2].to_f, 
               bid: row[3].to_f, 
               daily_low: row[4].to_f,
               daily_high: row[5].to_f,
               notes: row[6],
               is_valid: valid}
    end
    #records.first
  end

  def symbol_string(symbols)
    symbols.class.eql?(Array) ? symbols.join('+') : symbols
  end

  def remove_malformed_csv(result)
    result.gsub(/No such ticker symbol.+\)/, 'invalid')
  end

end

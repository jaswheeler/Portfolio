class AddMoreMarketDataToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :name, :string
    add_column :holdings, :bid, :decimal
    add_column :holdings, :ask, :decimal
    add_column :holdings, :daily_low, :decimal
    add_column :holdings, :daily_high, :decimal
    add_column :holdings, :notes, :string
    add_column :holdings, :is_valid, :boolean
  end
end

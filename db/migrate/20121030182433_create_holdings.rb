class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.string :symbol
      t.decimal :price
      t.integer :qty

      t.timestamps
    end
  end
end

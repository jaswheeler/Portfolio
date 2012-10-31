class Holding < ActiveRecord::Base
  validates :symbol, :price, :qty, presence: true
  validates :price, :qty, numericality: true
end

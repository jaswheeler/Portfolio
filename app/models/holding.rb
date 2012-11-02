class Holding < ActiveRecord::Base
  validates :symbol, :price, :qty, presence: true
  validates :price, :qty, numericality: true
  validate :must_be_valid_symbol

  def must_be_valid_symbol
    errors.add(:symbol, "unknown symbol") unless is_valid
  end
end

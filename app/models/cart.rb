class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  # LOGIC
  def sub_total
   #armarlo con .reduce
    sum = 0
    self.order_items.each do |order_item|
      sum+= order_item.total_price
    end
    return sum
  end
end

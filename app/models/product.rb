class Product < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_one_attached :photo
end

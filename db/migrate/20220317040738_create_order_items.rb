class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :quantity, default: 1
      t.references :product
      t.references :cart

      t.timestamps
    end
  end
end

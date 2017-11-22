class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user
  has_many :users, foreign_key: 'current_cart_id', class_name:'User'

  def add_item(item_id)
    @item = Item.find(item_id)
    if self.items.include?(@item)
      line_item = self.line_items.find_by(item: @item)
      line_item.quantity += 1
      line_item.save

      line_item
    else
      self.line_items.new(quantity: 1, item: @item)
    end
  end
  
  def total
    self.line_items.collect {|line_item|line_item.item.price * line_item.quantity}.sum
  end

  def checkout
    self.update(status: "submitted")
    self.user.update(current_cart: nil)
    self.items.each do |item|
      cart_item_quantity = self.line_items.find_by(item: item).quantity
      item.update(inventory: (item.inventory - cart_item_quantity))
    end
  end
end

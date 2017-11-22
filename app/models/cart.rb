class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user
  # has_many :users, foreign_key: 'cart_id'

  def add_item(item_id)
    @item = Item.find(item_id)
    @item.update(inventory: (@item.inventory -= 1))
    if self.items.include?(@item)
      line_item = self.line_items.find_by(item: @item)
      line_item.quantity += 1

      line_item
    else
      @item.line_items.new(quantity: 1, cart: self)
    end
  end
  
  def total
    self.line_items.collect {|line_item|line_item.item.price * line_item.quantity}.sum
  end
end

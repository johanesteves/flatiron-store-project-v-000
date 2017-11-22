class StoreController < ApplicationController

  def index
    @categories = Category.all
    @items = Item.available_items
    @cart = current_user.current_cart if current_user
  end
  
end

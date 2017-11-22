class LineItemsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    if !current_user.current_cart
      new_cart = current_user.carts.create
      current_user.update(current_cart: new_cart)
    end
    current_user.current_cart.add_item(@item)
    current_user.current_cart.save

    redirect_to cart_path(current_user.current_cart)
  end

end

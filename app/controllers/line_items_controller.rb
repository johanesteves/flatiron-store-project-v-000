class LineItemsController < ApplicationController

  def create
    @item = Item.find_by(params[:id])
    if !current_user.current_cart
      current_user.current_cart = current_user.carts.create
    end
    current_user.current_cart.add_item(@item)
    binding.pry

    redirect_to cart_path(current_user.current_cart.id)
  end

end

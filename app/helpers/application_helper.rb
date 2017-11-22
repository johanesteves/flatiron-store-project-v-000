module ApplicationHelper

  def current_cart
    Cart.find(params[:id])
  end

end

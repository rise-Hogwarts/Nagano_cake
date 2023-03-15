class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    old_cart_item = CartItem.find_by(item_id: @cart_item.item_id,customer_id: @cart_item.customer_id)
    if old_cart_item
    old_amount = old_cart_item.amount
     old_cart_item.update(amount: old_amount+@cart_item.amount)
    # if CartItem.find_by(item_id: @cart_item.item_id,customer_id: @cart_item.customer_id)
    # old_amount = CartItem.find_by(item_id: @cart_item.item_id,customer_id: @cart_item.customer_id).amount
    #   CartItem.find_by(item_id: @cart_item.item_id,customer_id: @cart_item.customer_id).update(amount: old_amount+@cart_item.amount)
    else
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end

class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm

    @cart_items = CartItem.all
    @order = Order.new(order_params)
    @order.order_status = 0
    if params[:order][:select_address] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      #orderに送られたselect_addressの値が(1)だったときのif文
    @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      #orderモデルに保存されているaddress_idからaddress
      #モデルに保存されているpostal_codeを呼び出す
    @order.address = Address.find(params[:order][:address_id]).address
    @order.name = Address.find(params[:order][:address_id]).name
    elsif params[:order][:select_address] == "2"
    else
      render :new
    end
    @total = 0
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.order_status = 0
    @order.save
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_details = OrderDetail.new
        @order_details.order_id = @order.id
        @order_details.item_id = cart_item.item.id
        @order_details.price = cart_item.item.price
        @order_details.quantity = cart_item.amount
        @order_details.production_status = "before"
        @order_details.save
      end
      current_customer.cart_items.destroy_all
      redirect_to complete_path
  end

  def index
    @order_details = OrderDetail.all
    @orders = Order.all
  end

  def show
    @order_details = OrderDetail.all
    @order = Order.find(params[:id])
    @total = 0
  end


  private
   def order_params
     params.require(:order).permit(:customer_id, :postage, :amount, :order_status, :payment_method, :postal_code, :address, :name)
   end

end

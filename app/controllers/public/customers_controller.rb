class Public::CustomersController < ApplicationController
  #before_action :is_matching_login_user

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id)
    end
  end

  def confirm_withdraw
    # # if current_customer
    # #   @customer = Customer.find_by(email: params[:customer][:email])
    # #   @customer.update(is_active: false)
    # reset_session
    # #   flash[:notice] = "退会処理を実行いたしました"
    # # else
    # #   flash[:alert] = "セッションが見つかりません"
    # redirect_to root_path
    # # end 
  end

  def withdraw
    # current_customer.update(status: 'withdrawn')
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private
  
  def customer_params
   	params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :phone_number, :is_active)
  end


end

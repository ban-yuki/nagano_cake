class Public::CustomersController < ApplicationController
  #before_action :is_matching_login_user

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
  end

  def confirm_withdraw
    if current_customer
      @customer = Customer.find(current_customer.id)
      @customer.update(is_active: false)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
    else
      flash[:alert] = "セッションが見つかりません"
      #redirect_to root_path
    end 
  end

  def withdraw
  end

  protected

end

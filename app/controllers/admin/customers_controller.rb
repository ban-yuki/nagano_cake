class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def show

  end

  def edit

  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
    redirect_to admin_items_path(@customer)
    else
    @customer = Customer.all
    render :edit
    end
  end

end

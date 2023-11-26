class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @item = Item.all
    @total = @cart_items.inject(0) { + cart_item.subtotal }
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id=current_customer.id
      @cart_items.each do |cart_item|
        if  @cart_item.save
          flash[:notice] = 'カートに商品が入りました。'
          redirect_to cart_items_path
        else
          flash[:alert] = '商品の追加に失敗しました。'
          render :show
        end
        unless @cart_items.pluck(:item_id).include?(@cart_item.item_id)
          new_quantity = cart_item.quantity + @cart_item.quantity
          cart_item.update_attribute(:quantity, new_quantity)
          @cart_item.delete
        end
      end
    end
  end
  
  def create
	if current_member.cart_items.count >= 1 #カート内に商品があるか？
	  if nil != current_member.cart_items.find_by(item_id: params[:cart_item][:item_id]) #カートに入れた商品はすでにカートに追加済か？
		   @cart_item_u = current_member.cart_items.find_by(item_id: params[:cart_item][:item_id]) #カート内のすでにある商品の情報取得
		   @cart_item_u.number_of_items += params[:cart_item][:number_of_items].to_i #既にある情報に個数を合算
		   @cart_item_u.update(number_of_items: @cart_item_u.number_of_items) #情報の更新　個数カラムのみ
		   redirect_to public_cart_items_path #カートページ遷移
		else
			@cart_item = CartItem.new(cart_item_params) #新しくカートの作成
			@cart_item.member_id = current_member.id #誰のカートか紐付け
			if @cart_item.save #情報を保存できるか？
				 redirect_to public_cart_items_path #カートページ遷移
			else
				@items = Item.where(sale_status: 0).page(params[:page]).per(8) #販売ステータスが「0」のものを見つける
		    @quantity = Item.count #商品の数をカウント
				render 'index' #indexアクションを呼び出す
		  end
	  end


	
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
    redirect_to admin_items_path(@cart_item)
    else
    @cart_items = CartItem.all
    render :edit
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
  　render 'index'
  end

  def destroy_all
    @cart_items = CartItems.all
    current_customer.cart_items.destroy_all
  　render 'index'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :quantity, :customer_id)
  end


class DiscountItemsController < ApplicationController
  # include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_discount_item, only: [:show, :edit, :update, :destroy]

  # GET /discount_items
  # GET /discount_items.json
  def index
    @discount_items = DiscountItem.all
  end

  # GET /discount_items/1
  # GET /discount_items/1.json
  def show
  end

  # GET /discount_items/new
  def new
    @discount_item = DiscountItem.new
  end

  # GET /discount_items/1/edit
  def edit
  end

  # POST /discount_items
  # POST /discount_items.json
  def create
    # @discount_item = DiscountItem.new(discount_item_params)
    discount = Discount.find(params[:discount_id])
    @discount_item = @cart.add_discount(discount)

    respond_to do |format|
      if @discount_item.save
        format.html { redirect_to @discount_item, notice: 'Discount item was successfully created.' }
        format.js { render partial: 'shared/cart', locals: { cart: @cart } }
        format.json { render :show, status: :created, location: @discount_item }
      else
        format.html { render :new }
        format.json { render json: @discount_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discount_items/1
  # PATCH/PUT /discount_items/1.json
  def update
    respond_to do |format|
      if @discount_item.update(discount_item_params)
        format.html { redirect_to @discount_item, notice: 'Discount item was successfully updated.' }
        format.json { render :show, status: :ok, location: @discount_item }
      else
        format.html { render :edit }
        format.json { render json: @discount_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discount_items/1
  # DELETE /discount_items/1.json
  def destroy
    @cart = @discount_item.cart
    @discount_item.destroy
    respond_to do |format|
      format.html { redirect_to discount_items_url, notice: 'Discount item was successfully destroyed.' }
      format.js { render partial: 'shared/cart', locals: { cart: @cart } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount_item
      @discount_item = DiscountItem.find(params[:id])
    end

    def set_cart
      @cart = Cart.find(params[:cart_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discount_item_params
      params.require(:discount_item).permit(:discount_id, :cart_id)
    end
end

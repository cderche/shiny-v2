class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy, :convert]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    # @cart = Cart.new(cart_params)
    @cart = Cart.new

    respond_to do |format|
      if @cart.save
        format.html { redirect_to edit_cart_path(@cart), notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # TODO REMOVE THIS METHOD
  def convert
    data = {
      user:           @cart.user           ,
      line_items:     @cart.line_items     ,
      discount_items: @cart.discount_items ,
      time:           @cart.start_time     ,
      date:           @cart.start_date     ,
      note:           @cart.note           ,
      card_id:        '697ee0b2-8db5-490c-8a92-9086587eb40e'
    }
    @order = Order.create(data)
    respond_to do |format|
      if @order
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:start_date, :start_time, :note, :user_id)
    end
end

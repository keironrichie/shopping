class ShoppingsController < ApplicationController
  before_action :set_shopping, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /shoppings
  # GET /shoppings.json
  def index
    @shoppings = Shopping.all
  #  @userstuff = user.email
  end

  # GET /shoppings/1
  # GET /shoppings/1.json
  def show
  end

  # GET /shoppings/new
  def new
    #@shopping = Shopping.new
    @shopping = current_user.shoppings.build
  end

  # GET /shoppings/1/edit
  def edit
  end

  # POST /shoppings
  # POST /shoppings.json
  def create
    #@shopping = Shopping.new(shopping_params)
    @shopping = current_user.shoppings.build(shopping_params)
    respond_to do |format|
      if @shopping.save
        format.html { redirect_to shoppings_url, notice: 'Item was successfully added.' }
        format.json { render :show, status: :created, location: @shopping }
      else
        format.html { render :new }
        format.json { render json: @shopping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shoppings/1
  # PATCH/PUT /shoppings/1.json
  def update
    respond_to do |format|
      if @shopping.update(shopping_params)
        format.html { redirect_to @shopping, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @shopping }
      else
        format.html { render :edit }
        format.json { render json: @shopping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shoppings/1
  # DELETE /shoppings/1.json
  def destroy
    @shopping.destroy
    respond_to do |format|
      format.html { redirect_to shoppings_url, notice: 'Item removed from shopping list.' }
      format.json { head :no_content }
    end
  end

  def correct_user
    @shopping = current_user.shoppings.find_by(id: params[:id])
    redirect_to shopping_path, notice: "Not Authorised to edit this item" if @shopping.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopping
      @shopping = Shopping.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shopping_params
      params.require(:shopping).permit(:item, :size, :quantity, :comment, :user_id, :created_at)
    end
end

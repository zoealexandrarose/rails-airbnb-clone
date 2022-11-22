class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show new create]
  before_action :set_product, only: %i[show new]

  def index
    @products = Product.all
  end

  def show
    @name = @product.name
    @description = @product.description
    @price = @product.price
    @user = @product.user_id
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = @user
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end

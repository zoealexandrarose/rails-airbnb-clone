class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_product, only: %i[show]

  def index
    @products = Product.all
  end

  def show
    @name = @product.name
    @description = @product.description
    @price = @product.price
    @user = @product.user
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end

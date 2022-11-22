class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def index
    @products = Product.all
  end

  def show
    @name = @product.name
    @description = @product.description
    @user = Product.find(params[:user_id])
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end

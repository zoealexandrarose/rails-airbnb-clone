class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show new create]
  before_action :set_product, only: %i[show]

  def index
    @products = Product.all
    @markers = @products.geocoded.map do |product|
      {
        lat: product.latitude,
        lng: product.longitude,
        info_window: render_to_string(partial: "info_window", locals: { product: product }),
        image_url: helpers.asset_url("logo.png")
      }
    end
  end

  def show
    @name = @product.name
    @description = @product.description
    @price = @product.price
    @user = @product.user
    @booking = Booking.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
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
    params.require(:product).permit(:name, :description, :price, :photo, :address)
  end
end

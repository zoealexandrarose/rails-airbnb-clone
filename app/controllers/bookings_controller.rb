class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    @product = Product.find(@booking.product_id)
    @markers = [
      {
        lat: @product.latitude,
        lng: @product.longitude,
        # info_window: render_to_string(partial: "info_window", locals: { product: @product }),
        image_url: helpers.asset_url("logo.png")
      }
    ]
  end

  def new
    @product = Product.find(params[:product_id])
    @booking = Booking.new
  end

  def create
    @product = Product.find(params[:product_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.product = @product

    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:message, :user_id, :product_id)
  end
end

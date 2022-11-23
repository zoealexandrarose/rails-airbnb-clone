class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
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
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:message, :user_id, :product_id)
  end
end

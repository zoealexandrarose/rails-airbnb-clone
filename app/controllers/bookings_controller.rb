class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to product_path(:id)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :product_id)
  end
end

class BookingsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @booking = Booking.new
  end

  def create
    @user = User.find(params[:user_id])
    @booking = Booking.new(booking_params)
    @booking.user = @user
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

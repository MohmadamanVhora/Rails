class AddressesController < ApplicationController
  before_action :find_address
  def edit; end

  def update
    if @address.update(address_params)
      redirect_to profiles_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def find_address
    @address = Address.find_by(user_id: @current_user[:id])
  end

  def address_params
    params.require(:address).permit(:address_line, :city, :state)
  end
end

class RestaurantsController < ApplicationController
  respond_to :html, :json

  def index
    @hotels = Hotel.all
    respond_with(@hotels) do |format|
      format.json { render :json => @hotels.as_json }
      format.html
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user.as_json, status: :ok
    else
      render json: {user: @user.errors, status: :no_content}
    end
  end      

  def show
    @hotel = Hotel.find(params[:id])
    respond_with(@hotel) do |format|
      format.json { render :json => @hotel.as_json }
      format.html
    end
  end

  def update
    if @user.update_attributes(user_params)
      render json: @user.as_json, status: :ok 
    else
      render json: {user: @user.errors, status: :unprocessable_entity}
    end
  end

  def destroy
    @user.destroy
    render json: {status: :ok}
  end

  private

  def user_params
    unless params["user"]["addresses"].blank?
      params["user"]["addresses_attributes"] = params["user"]["addresses"]
      params["user"].delete("addresses")
    end
    params.fetch(:user, {}).permit(:first_name, :last_name, :email, :phone, 
                                   :addresses_attributes => [:id, :street1, :street2, :city, :state, :country, :zipcode, :_destroy, :user_id])
  end

  def get_user
    @user = User.find(params[:id])
    render json: {status: :not_found} unless @user
  end
end

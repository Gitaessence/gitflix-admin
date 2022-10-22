class Api::V1::ProfilesController < ApplicationController
  include Utils
  before_action :authenticate_user!

  def updateUserDetails
    createOrUpdateUser

    render json: { :success => true, :message => "User profile updated!" }, :status => 201
  end

  def updateUserAddress
    params[:user_id] = current_user.id
    user_details = UserInfo.find_by(user_id: params[:user_id])

    if !user_details
      user_details = UserInfo.create(profile_params)
    end
    
    if !user_details.user_address_id
      # create an address instance
      user_addr_inst = UserAddress.create(address_params)

      user_details.user_address_id = user_addr_inst.id
      user_details.save
    else
      # UserAddress.update(address_params)
      user_addr_inst = UserAddress.find_by(id: user_details.user_address_id)
      user_addr_inst.update(address_params)
    end

    render json: { :success => true, :message => "User address updated!" }, :status => 201
  end

  def getUserDetails
    user_id = current_user.id

    user_details = User.select("email").where(id: user_id, email_confirmed: true).first

    if user_details.nil?
      render json: { :success => false, :message => "No user found!" }, :status => 404
      return
    end

    user_info = user_details ? UserInfo.with_attached_user_avatar.where(user_id: user_id).first : {}
    user_addr = user_info ? UserAddress.select("city, state, pincode, address").find_by(id: user_info["user_address_id"]) : {}
    
    response = {
      :email => user_details.email,
      :name => user_info.name,
      :dob => user_info.dob,
      :phone_number => user_info.phone_number,
      :whatsapp_number => user_info.whatsapp_number,
      :gender => user_info.gender,
      :user_avatar => user_info.user_avatar ? get_asset_url(user_info.user_avatar.key || nil) : nil,
      :city => user_addr.city,
      :state => user_addr.state,
      :pincode => user_addr.pincode,
      :address => user_addr.address,
    }

    render json: { :success => true, :data => response }, :status => 200
  end

  private

  def createOrUpdateUser
    params[:user_id] = current_user.id
    user_details = UserInfo.find_by(user_id: params[:user_id])

    if !user_details
      user_details = UserInfo.create(profile_params)
    else
      user_details = UserInfo.update(profile_params)
    end

    return user_details
  end

  def profile_params
    params.permit(:name, :user_address, :gender, :profile_photo_url, :whatsapp_number, :phone_number, :dob, :user_id, :user_avatar)
  end

  def address_params
    params.permit(:city, :state, :pincode, :address)
  end
end
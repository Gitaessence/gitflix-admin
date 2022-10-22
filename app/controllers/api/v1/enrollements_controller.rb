class Api::V1::EnrollementsController < ApplicationController
  before_action :authenticate_user!

  def enrollUser
    if params[:category_id] && Category.find_by(id: params[:category_id])
      user_id = current_user.id

      enrollement_exist = Enrollement.where(category_id: params[:category_id], user_id: user_id)[0]

      if !enrollement_exist
        # no enrollement exist
        enroll_inst = Enrollement.new
        enroll_inst.user_id = user_id
        enroll_inst.category_id = params[:category_id]
        enroll_inst.start_date = Time.zone.now
        enroll_inst.save

        render json: { :success => true, :message => "User is enrolled to category id #{params[:category_id]}" }, :status => 200
      else
        # user already enrolled
        render json: { :success => true, :message => "User already enrolled!" }, :status => 409
      end

    else
      render json: { :success => false, :message => "Category id not found!" }, :status => 404
    end
  end

  def getAllEnrolledCategories
    enrollements = Enrollement.select("category_id, start_date, end_date, course_completed, progress").where(user_id: current_user.id).as_json(:except => :id)

    if enrollements
      render json: { :success => true, :data => enrollements }, :status => 200
    else
      render json: { :success => false, :data => [], :message => "Not found!" }, :status => 404
    end
  end  
end
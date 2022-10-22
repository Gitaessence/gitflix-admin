class Api::V1::CategoriesController < ApplicationController
  include Utils
  # respond_to :json
  # before_action :authenticate_user!

  def getCategories
    limit = params[:limit] ? params[:limit].to_i : 10
    offset = params[:offset] ? params[:offset].to_i : 0

    # categories = Category.select(self.allowed_fields).where(enabled: true).limit(limit).offset(offset * limit)
    categories = Category.with_attached_author_avatar.with_attached_category_image.where(enabled: true).limit(limit).offset(offset * limit)
    response = []

    categories.each do | categ |
      response.push({
        :id => categ.id,
        :name => categ.name,
        :details => categ.details,
        :enabled => categ.enabled,
        :author_name => categ.author_name,
        :about_author => categ.about_author,
        :age_criteria => categ.age_criteria,
        :start_date => categ.start_date,
        :end_date => categ.end_date,
        :total_duration => categ.total_duration,
        :is_free => categ.is_free,
        :is_paid => categ.is_paid,
        :author_avatar => get_asset_url(categ.author_avatar.key || nil),
        :category_image => get_asset_url(categ.category_image.key || nil),
        :course_level => categ.course_level_id
      })
    end

    if categories
      render json: { :success => true, :data => response }, :status => 200
    else
      render json: { :success => false, :data => [], :message => 'No data found' }, :status => 404
    end
  end

  def getCategory
    if params[:id]
      category = Category.with_attached_author_avatar.with_attached_category_image.where(id: params[:id], enabled: true)
      if category.nil?
        render json: { :success => false, :data => [], :message => "No data found!" }, :status => 404
      else
        response = []
        category.each do | categ |
          response.push({
            :id => categ.id,
            :name => categ.name,
            :details => categ.details,
            :enabled => categ.enabled,
            :author_name => categ.author_name,
            :about_author => categ.about_author,
            :age_criteria => categ.age_criteria,
            :start_date => categ.start_date,
            :end_date => categ.end_date,
            :total_duration => categ.total_duration,
            :is_free => categ.is_free,
            :is_paid => categ.is_paid,
            :author_avatar => get_asset_url(categ.author_avatar.key || nil),
            :category_image => get_asset_url(categ.category_image.key || nil),
            :course_level => categ.course_level_id
          })
        end
        render json: { :success => true, :data => response }, :status => 200
      end
    else
      render json: { :success => false, :data => [], :message => 'No id provided' }, :status => 400
    end
  end

  def getItems
    if params[:category_id]
      # items = Item.select(self.allowed_fields_items).where(category_id: params[:category_id])
      items = Item.with_attached_item_image.where(category_id: params[:category_id])
      response = []

      items.each do | item |
        response.push({
          :name => item.name,
          :details => item.details,
          :content_url =>  current_user ? item.content_url : nil,
          :category_name => item.category.name,
          :item_image => get_asset_url(item.item_image.key || nil)
        })
      end

      if items
        render json: { :success => true, :data => response }, :status => 200
      else
        render json: { :success => false, :data => [] }, :status => 404
      end
    else
      render json: { :success => false, :data => [], :message => "No category id provided" }, :status => 400
    end
  end

  def getBanners
    banners = Banner.with_attached_banner_image.where(active: true)
    new_banners = []

    banners.each do | obj |
      new_banners.push({
        :image_info => obj.image_info,
        :active => obj.active,
        :device_type => obj.device_type,
        :banner_image => get_asset_url(obj.banner_image.key || nil)
      })
    end

    if banners
      render json: { :success => true, :data => new_banners }, :status => 200
    else
      render json: { :success => false, :data => [], :message => "Not found!" }, :status => 404
    end
  end

  def getTestimonials
    testimonials = Testimonial.with_attached_author_avatar.where(active: true)
    new_testimonials = []

    testimonials.each do |obj|
      new_testimonials.push({
        :author_name => obj.author_name,
        :details => obj.details,
        :active => obj.active,
        :author_avatar => get_asset_url(obj.author_avatar.key || nil)
      })
    end

    if testimonials
      render json: { :success => true, :data => new_testimonials }, :status => 200
    else
      render json: { :success => false, :data => [], :message => "Not found!" }, :status => 404
    end
  end

  def getAllLevels
    course_levels = CourseLevel.select("id, name").all

    if course_levels
      render json: { :success => true, :data => course_levels }, :status => 200
    else
      render json: { :success => true, :data => [], :message => "Not found!" }, :status => 404
    end
  end

  private

  def allowed_fields
    "id, name, details, enabled, author_name, author_image, about_author, course_image, age_criteria, start_date, end_date, total_duration, is_free, is_paid"
  end

  def allowed_fields_items
    # if user is logged in, then only return content url
    if current_user
      "id, name, details, image_url, content_url, category_id"
    else
      "id, name, details, image_url, category_id"
    end
  end
end
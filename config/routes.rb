Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "admin/dashboard#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get "users/confirm_account/:id", :to => "users/registrations#confirm_account", :as => "user_confirm_account"
  end

  namespace :api, default: { format: :json} do
    namespace :v1 do
      get "category", :to => "categories#getCategories"
      get "category/:id", :to => "categories#getCategory"
      get "item", :to => "categories#getItems"
      get "banner", :to => "categories#getBanners"
      get "testimonial", :to => "categories#getTestimonials"
      get "courselevels", :to => "categories#getAllLevels"

      post "enroll", :to => "enrollements#enrollUser"
      get "enrolled/categories", :to => "enrollements#getAllEnrolledCategories"

      post "user/profile", :to => "profiles#updateUserDetails"
      post "user/address", :to => "profiles#updateUserAddress"
      get "user/profile", :to => "profiles#getUserDetails"
    end
  end

  # namespace :api, defaults: { format: :json } do
  #   namespace :users do
  #     resources :users, only: %w[show]
  #   end
  # end

  # namespace :api, defaults: { format: 'json' } do
  #   namespace :v1 do
      # resources :categories
  #   end
  # end

  # devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

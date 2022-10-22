class Users::RegistrationsController < Devise::RegistrationsController
  # respond_to :json
  
  def confirm_account
    @user = User.find_by(confirm_token: params[:id])

    if @user
      @user.update(email_confirmed: true)
    end
  end

  private
  
  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed(resource, _opts)
  end

  def register_success
    current_user.send_activation_mail
    render json: { success: true, message: 'An email has been sent, check your email to activate your account' }
  end

  def register_failed(resource, _opts)
    render json: { success: false, message: "Signed up failure.", errors: resource.errors.full_messages }
  end
end
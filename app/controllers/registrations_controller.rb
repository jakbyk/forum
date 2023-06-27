class RegistrationsController < Devise::RegistrationsController
  def new
    @errors   = flash[:errors] || nil
    @nickname = flash[:nickname] || ''
    @email    = flash[:email] || ''
    super
  end

  def create
    user = User.create(user_params)
    if user.save
      self.resource = warden.authenticate(auth_options)
      if current_user
        redirect_to notes_path, notice: "Success register"
      else
        redirect_to user_session_path, notice: "You need to log in to proceed"
      end
    else
      flash[:errors]   = user.errors.messages
      flash[:nickname] = user.nickname
      flash[:email]    = user.email
      redirect_to user_registration_path, alert: "Wrong data to register"
    end
  end

  def update
    super
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end

  private

  def auth_options
    { recall: "#{user_session_path}#new" }
  end
end

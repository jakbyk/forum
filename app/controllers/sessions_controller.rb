class SessionsController < Devise::SessionsController
  def new
    request.variant = :no_turbo
    @email  = flash[:email] || ''
    @errors = flash[:errors] || nil
    super
  end

  def create
    self.resource = warden.authenticate(auth_options)

    if current_user
      redirect_to notes_path, notice: "Successfully logged in"
    else
      flash[:email]             = params.dig(:user, :email)
      flash[:errors]            = {}
      flash[:errors][:email]    = ["This email does not exist in the database"] unless User.find_by(email: params.dig(:user, :email))
      flash[:errors][:password] = ["Wrong password"] if User.find_by(email: params.dig(:user, :email))
      flash[:alert]             = nil if flash[:errors].present?
      redirect_to user_session_path
    end
  end

  def destroy
    super
  end

  private

  def auth_options
    { recall: "#{controller_path}#new" }
  end
end

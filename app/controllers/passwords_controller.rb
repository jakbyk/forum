class PasswordsController < Devise::PasswordsController
  def edit
    super
    @errors = flash[:errors]
    respond_to do |format|
      format.html
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if resource_class.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        resource.after_database_authentication
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      flash[:errors] = resource.errors
      set_minimum_password_length
      redirect_back_or_to user_session_path, alert: "Wrong data to reset password"
    end
  end

  protected

  def respond_with(resource, _opts = {})
    if resource.is_a?(Hash) && resource.empty?
      super
    elsif resource.errors.empty?
      flash[:notice] = 'Password update complete.'
      redirect_to notes_path
    else
      flash[:errors] = resource.errors
      redirect_to request.fullpath
    end
  end
end

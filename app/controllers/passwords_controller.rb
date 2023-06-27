class PasswordsController < Devise::PasswordsController
  def edit
    super
    @errors = flash[:errors]
    respond_to do |format|
      format.html
    end
  end

  def update
    super
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

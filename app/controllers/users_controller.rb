class UsersController < ActionController::Base

  private

  def user
    @user ||= User.find(params[:id])
  end
  helper_method :user
end

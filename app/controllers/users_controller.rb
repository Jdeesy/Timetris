class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.alerts_enabled = user_params[:alerts_enabled]
    @user.save
    redirect_to edit_user_path
  end

  def snooze
    current_user.update(user_params)
    render :nothing => true
  end

  def alerts
    render json: { alerts: current_user.show_alerts }.to_json
  end

  private

  def user_params
    params.require(:user).permit(:snooze_until, :default_time_increment, :alerts_enabled)
  end

end

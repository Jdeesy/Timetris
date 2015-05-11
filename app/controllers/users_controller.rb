class UsersController < ApplicationController

  def edit

  end

  def update

  end

  def snooze
    current_user.update(user_params)
    render :nothing => true
  end

  def alerts
    render json: { alerts: current_user.show_alerts? }.to_json
  end

  private

  def user_params
    params.require(:user).permit(:snooze_until)
  end

end

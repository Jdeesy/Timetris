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

  def alert
    if request.xhr? && current_user.show_alerts
      upcoming_events = current_user.upcoming_events
      task = current_user.possible_tasks(upcoming_events).first
      if task
        current_user.last_alert = Time.now
        current_user.save
        render json: task
      else
        render nothing: true
      end
    else
      render nothing: true
    end
  end

  def snooze
    current_user.update(user_params)
    render :nothing => true
  end

  private

  def user_params
    params.require(:user).permit(:snooze_until, :default_time_increment, :alerts_enabled)
  end

end

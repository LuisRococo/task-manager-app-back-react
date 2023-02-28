# frozen_string_literal: true

class UsersController < ApplicationController
  authorize_persona class_name: 'User'
  grant(
    user: :all,
    manager: :all,
    admin: :all
  )

  skip_before_action :block_trial_expirated_users, only: [:set_plan]
  before_action :set_user, except: [:set_plan, :toggle_random_message]
  before_action :access_to_crud, only: %i[end_trial edit update toggle_board_delete_emails toggle_board_update_emails toggle_board_create_emails]
  before_action :current_user_admin, only: [:toggle_user_block]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = 'The user was updated'
    else
      flash.now[:alert] = 'There was an error'
      render :edit
    end
  end

  def toggle_board_delete_emails
    @user.board_delete_notification = !@user.board_delete_notification
    @user.save
    if @user.board_delete_notification
      flash[:notice] = 'Board deletion notification are on'
    else
      flash[:notice] = 'Board deletion notification are off'
    end
    redirect_back(fallback_location: root_path)
  end

  def toggle_board_update_emails
    @user.board_update_notification = !@user.board_update_notification
    @user.save
    if @user.board_update_notification
      flash[:notice] = 'Board update notification are on'
    else
      flash[:notice] = 'Board update notification are off'
    end
    redirect_back(fallback_location: root_path)
  end

  def toggle_board_create_emails
    @user.board_create_notification = !@user.board_create_notification
    @user.save
    if @user.board_create_notification
      flash[:notice] = 'Board creation notification are on'
    else
      flash[:notice] = 'Board creation notification are off'
    end
    redirect_back(fallback_location: root_path)
  end

  def end_trial
    @user.end_trial_period
    flash[:notice] = 'Trial period has finished'
    redirect_back(fallback_location: root_path)
  end

  def set_plan
    unless current_user.can_plan_be_set?
      flash[:alert] = 'Can not set plan to this user'
      redirect_back(fallback_location: root_path)
      return
    end

    plan_to_add = Plan.find(params[:plan_id])
    current_user.change_plan(plan_to_add)

    flash[:notice] = "You now have the '#{plan_to_add.title}' plan"
    redirect_to new_payment_path
  end

  def toggle_user_block
    @user.toggle_block_user
    message = @user.has_user_block? ? 'User has been blocked' : 'User has been unblocked'
    flash[:notice] = message
    redirect_back(fallback_location: root_path)
  end

  def toggle_random_message
    if cookies[:random_message_active]
      cookies.delete :random_message_active
      flash[:notice] = 'Random quotes are unabled'
    else
      cookies.permanent[:random_message_active] = 'true'
      flash[:notice] = 'Random quotes are abled'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def current_user_admin
    unless current_user.authorization_tier == 'admin'
      flash[:alert] = 'You do not have access to this feature'
      redirect_back(fallback_location: root_path)
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def access_to_crud
    unless access_to_user_crud?(@user)
      flash[:alert] = 'You do not have access to modify this user'
      redirect_back(fallback_location: root_path)
    end
  end
end

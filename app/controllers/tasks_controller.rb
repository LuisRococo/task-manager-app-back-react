# frozen_string_literal: true

class TasksController < ApplicationController
  authorize_persona class_name: 'User'
  grant(
    user: :all,
    manager: :all
  )
  before_action :block_access_to_admin
  before_action :set_task_list, only: %i[new create index]
  before_action :set_task, except: %i[new create index]
  before_action :valid_task_incompleted, only: [:complete_task]
  before_action :validate_task_list, only: %i[new create index]
  before_action :validate_task, except: %i[new create index]
  before_action :validate_task_auth, only: %i[edit update complete complete_task_action]

  def index
    @tasks = @task_list.tasks
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.creator = current_user
    if @task.save
      flash[:notice] = 'Task saved successfully'
      redirect_to board_path(@task_list.board)
    else
      flash.now[:alert] = 'There was an error on saving the task'
      render 'new'
    end
  end

  def edit; end

  def update
    Task.transaction do
      @task.update(task_params)
    end
    flash[:notice] = 'Task updated successfully'
    redirect_to board_path(@task.board)
  rescue StandardError
    flash[:alert] = 'There was an error'
    render 'edit'
  end

  def destroy
    if @task.destroy
      flash[:notice] = 'Task was deleted successfully'
    else
      flash[:alert] = 'There was an error deleting the task'
    end

    redirect_to task_list_path(@task.task_list)
  end

  def complete_task; end

  def complete_task_action
    Task.transaction do
      @task.update(complete_task_params)
      doing_time = (@task.finished_at - @task.started_at).to_i
      @task.update(doing_time: doing_time)
      @task.update(completed: true)
    end

    flash[:notice] = 'Task mark as completed'
    redirect_to board_path(@task.board)
  rescue ActiveRecord::ActiveRecordError
    flash.now[:alert] = 'There was an error'
    render complete_task
  end

  private

  def validate_task_auth
    unless @task.has_auth_to_update?(current_user)
      flash[:alert] = 'You do not have access to perform this action'
      redirect_back(fallback_location: root_path)
    end
  end

  def set_task_list
    @task_list = TaskList.find_by(id: params[:task_list_id])
  end

  def task_params
    params.require(:task).permit(:title, :task_id, :content, :task_list_id)
  end

  def complete_task_params
    params.permit(:started_at, :finished_at, :justification, :task_list_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def valid_task_incompleted
    if @task.completed
      flash[:alert] = 'That task is already completed'
      redirect_to task_path(@task)
    end
  end

  def validate_task_list
    unless current_user.is_manager_or_manager_team?(@task_list.board.author)
      flash[:alert] = 'You cannot access this task list'
      redirect_back(fallback_location: root_path)
    end
  end

  def validate_task
    unless current_user.is_manager_or_manager_team?(@task.task_list.board.author)
      flash[:alert] = 'You cannot access this task'
      redirect_back(fallback_location: root_path)
    end
  end
end

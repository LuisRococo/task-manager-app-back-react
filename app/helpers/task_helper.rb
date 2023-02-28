# frozen_string_literal: true

module TaskHelper
  def task_new_header
    { title: 'Tasks',
      text: 'Create a new task and start working on it.',
      config: true }
  end

  def task_edit_header
    { title: 'Tasks',
      text: 'Edit a task',
      config: true }
  end

  def task_index_header(task_list)
    { title: 'Tasks',
      text: "You are watching all the tasks from #{task_list.title} list",
      config: true }
  end

  def task_form_models
    @task&.id.nil? ? [@task_list, @task] : [@task]
  end

  def task_form_task_lists
    @task&.id.nil? ? @task_list.board.task_lists : @task.board.task_lists
  end

  def task_complete_page_header
    { title: 'Complete task',
      text: 'Set task as completed',
      config: true }
  end

  def task_show_page_header
    { title: 'Task',
      text: 'See details of task',
      config: true }
  end

  def task_user_id_from_user_task(user, task)
    TaskUser.find_by(user: user, task: task).id
  end

  def board_task_label_title(task)
    task.completed ? 'Finished' : 'Incomplete'
  end

  def board_task_label_style(task)
    task.completed ? 'bg-success' : 'bg-secondary'
  end
end

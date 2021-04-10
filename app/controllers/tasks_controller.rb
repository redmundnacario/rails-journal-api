class TasksController < ApplicationController
  before_action :authorized
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    # @tasks = Task.all
    @tasks = Task.where(user_id: @user.id)
    render json: {
                  status: "Success",
                  message: "Tasks loaded.",
                  data: @tasks
                  }
  end

  def get_tasks_by_journal_id
    # validate journal if existing

    # process
    @tasks = Task.where({journal_id: params[:id], user_id: @user.id })
    render json: {
                  status: "Success",
                  message: "Tasks loaded.",
                  data: @tasks
                  }, status: :ok
  end

  def get_tasks_today
    @tasks = Task.where({user_id: @user.id, deadline: Date.today.iso8601})
    # ,'start BETWEEN ? AND ?', Date.today.prev_day.iso8601, Date.today.next_day.iso8601
    render json: {
                  status: "Success",
                  message: "Tasks loaded.",
                  data: @tasks
                  }, status: :ok
  end

  def get_tasks_today_by_journal_id
    @tasks = Task.where({journal_id: params[:id], user_id: @user.id, deadline: Date.today.iso8601})
    # ,'start BETWEEN ? AND ?', Date.today.prev_day.iso8601, Date.today.next_day.iso8601
    render json: {
                  status: "Success",
                  message: "Tasks loaded.",
                  data: @tasks
                  }, status: :ok
  end


  # GET /tasks/1
  def show
    render json: {
                  status: "Success",
                  message: "Task loaded.",
                  data: @task
                  }, status: :ok
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = @user.id

    if @task.save
      render  json: {
                      status: "Success",
                      message: "Task created.",
                      data: @task
                      }, status: :created
    else
      render json: {
                    status: "Error",
                    message: "Task not created.",
                    data: @task.errors
                    }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: {
                    status: "Success",
                    message: "Task updated.",
                    data: @task
                    }, status: :ok
    else
      render json: {
                    status: "Error",
                    message: "Task not updated.",
                    data: @task.errors
                    }, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    if @task.present?
      @task.destroy
      render json: {
                    status: "Success",
                    message: "Task deleted.",
                    }, status: :ok
    else
      render json: {
                    status: "Error",
                    message: "Task not deleted.",
                    }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.where({ id:params[:id], user_id: @user.id })
      return item_not_found
    end

    def item_not_found
      if @task.length == 0
        error = {message: "Task not found."}
        render json: error, status: 404
      else
        @task = @task[0]
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :deadline, :done, :journal_id)
    end
end

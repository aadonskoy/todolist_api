class API::V1::TasksController < API::BaseController
  before_action :task_by_id, only: [:update, :destroy, :show]
  def index
    tasks = @current_user.tasks
    render json: tasks
  end

  def show
    render json: @task
  end

  def create
    task = Task.create(task_params.merge(user_id: @current_user.id))
    render json: task
  end

  def update
    @task.update_attributes(task_params)
    render json: @task
  end

  def destroy
    @task.destroy
    render json: @task
  end

  private

  def task_params
    params.permit(:time, :description, :status)
  end

  def task_by_id
    @task = @current_user.tasks.where(id: params[:id]).first
    return render(json: '{"error": "There is no record found!"}', status: 404) if @task.nil?
  end
end

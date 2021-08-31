class TasksController < ApplicationController
  after_action :set_csrf_token_header, only: %i[ update ]
  before_action :set_task, only: %i[ edit update destroy ]

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save!
        format.json { render index: @task, status: :created}
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    id = params[:id]
    title = params[:title]
    params = {id: id,task: {title: title}}
    # binding.irb
    respond_to do |format|
      if @task.update(task_params)
        format.json { render index: @task, status: :created }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    render :index
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title)
    end
end

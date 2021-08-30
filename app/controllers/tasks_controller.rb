class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update destroy ]

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.to_json
    @tasks = Task.all.to_json
    respond_to do |format|
      if @task.save
        format.json { render :index, status: :created, location: @tasks  }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @tasks = Task.all.to_json
    respond_to do |format|
      if @task.update(task_params)
        format.json { render index: @tasks, status: :created }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title)
    end
end

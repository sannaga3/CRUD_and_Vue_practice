class TasksController < ApplicationController

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def create
    @task = Task.new(params.require(:task).permit(:title))
    respond_to do |format|
      format.json { render index: @task, status: :created} and return if @task.save
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      format.json { render index: @task, status: :created } and return if @task.update(params.require(:task).permit(:id, :title))
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    render :index
  end
end

class BlogsController < ApplicationController

  def index
    @blogs = Blog.order(id: :desc)
    @blogs_json = Blog.order(id: :desc).to_json(except: [:update])
  end

  def create
    @blog = Blog.new(params.require(:blog).permit(:content))
    @blogs = Blog.order(id: :desc)
    respond_to do |format|
      format.json { render :show, status: :created, location: @blog } and return if @blog.save
      format.json { render json: @blog.errors, status: :unprocessable_entity }
    end
  end

  def update
    @blog = Blog.find(params[:id])
    content = @blog.content
    @blogs = Blog.order(id: :desc)
    respond_to do |format|
      if @blog.update(params.require(:blog).permit(:content))
        format.json { render :show, status: :ok, location: @blog }
      else
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    content = @blog.content
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_path, notice: "#{content}を削除" }
      format.json { head :no_content }
    end
  end
end

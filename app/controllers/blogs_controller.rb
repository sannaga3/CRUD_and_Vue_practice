class BlogsController < ApplicationController

  def index
    @blogs = Blog.order(id: :desc)
  end

  def create
    @blog = Blog.new(params.require(:blog).permit(:content))
    @blogs = Blog.order(id: :desc)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blogs_path, notice: "新規ブログ#{@blog.content}作成" }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @blog = Blog.find(params[:id])
    content = @blog.content
    @blogs = Blog.order(id: :desc)
    respond_to do |format|
      if @blog.update(params.require(:blog).permit(:content))
        format.html { redirect_to blogs_path, notice: "#{content}から#{@blog.content}へ更新" }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :index, status: :unprocessable_entity }
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

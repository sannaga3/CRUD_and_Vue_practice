class MemosController < ApplicationController

  def index
    @memos = Memo.order(id: :desc)
  end

  def create
    @memo = Memo.new(params.require(:memo).permit(:content))
    @memos = Memo.order(id: :desc)
    redirect_to memos_path, notice: "新規メモ#{@memo.content}作成" and return if @memo.save
    render :index, status: :unprocessable_entity
  end

  def update
    @memo = Memo.find(params[:id])
    content = @memo.content
    @memos = Memo.order(id: :desc)
    redirect_to memos_path, notice: "#{content}から#{@memo.content}へ更新" and return if @memo.update(params.require(:memo).permit(:id, :content))
    render :index, status: :unprocessable_entity
  end

  def destroy
    @memo = Memo.find(params[:id])
    content = @memo.content
    @memo.destroy
    redirect_to memos_path, notice: "#{content}を削除"
  end
end

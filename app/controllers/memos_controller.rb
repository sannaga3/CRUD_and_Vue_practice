class MemosController < ApplicationController

  def index
    @memos = Memo.order(id: :desc)
    # ＠memo = Memo.new しない理由
    # update でエラーが起きた後に create のフォームを送信した場合、既存インスタンスのupdateとして扱われてしまう。
    # form_withでnewすると update の @memo と区別できる
  end

  def create
    @memo = Memo.new(params.require(:memo).permit(:content))
    @memos = Memo.order(id: :desc)
    if @memo.save
      redirect_to memos_path, notice: "Memo was successfully created."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @memo = Memo.find(params[:id])
    @memos = Memo.order(id: :desc)
    if @memo.update(params.require(:memo).permit(:content))
      redirect_to memos_path, notice: "Memo was successfully updated."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    redirect_to memos_path, notice: "Memo was successfully destroyed."
  end
end

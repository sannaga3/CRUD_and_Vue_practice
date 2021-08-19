class MemosController < ApplicationController

  def index
    @memos = Memo.order(id: :desc)
    # ＠memo = Memo.new すると update でエラーが起きた後に create するとエラーが出たインスタンスのupdateとして扱われてしまう。
    # form_withでnewすると update の @memo と区別できる
  end

  def create
    @memo = Memo.new(memo_params)
    @memos = Memo.order(id: :desc)

    respond_to do |format|
      if @memo.save
        format.html { redirect_to memos_path, notice: "Memo was successfully created." }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @memo = Memo.find(params[:id])
    @memos = Memo.order(id: :desc)
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to memos_path, notice: "Memo was successfully updated." }
        format.json { render :index, status: :ok, location: @memo }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_url, notice: "Memo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def memo_params
      params.require(:memo).permit(:content)
    end
end

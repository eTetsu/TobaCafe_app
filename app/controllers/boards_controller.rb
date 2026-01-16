class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @boards = Board.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)

    if @board.save
      redirect_to boards_path, success: "カフェの登録に成功しました"
    else
      flash.now[:danger] = "カフェの登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.includes(:user).find(params[:id])
    @review = current_user.reviews.find_or_initialize_by(board: @board) if current_user
    @reviews = @board.reviews.includes(:user).order(created_at: :desc)
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])

    if @board.update(board_params)
      redirect_to board_path(@board), success: "更新が完了しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = current_user.find(params[:id])
    board.destroy!
    redirect_to boards_path, success: "削除に成功しました", status: :see_other
  end

  private

  def board_params
    params.require(:board).permit(:title, :address, :nearest_station, :opening_hours, :smoking_policy)
  end
end

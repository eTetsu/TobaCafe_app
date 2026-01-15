class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @boards = Board.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.includes(:user).find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)

    if @board.save
      redirect_to boards_path, success: "カフェの登録に成功しました"
    else
      flash.now[:danger] = "カフェの登録に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :address, :nearest_station, :opening_hours, :smoking_policy)
  end
end

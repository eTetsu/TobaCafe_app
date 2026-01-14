class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @boards = Board.includes(:user).order(created_at: :desc).page(params[:page])
  end
end

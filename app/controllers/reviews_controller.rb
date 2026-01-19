class ReviewsController < ApplicationController
  def create
    review = current_user.reviews.build(review_params)
    if review.save
      redirect_to board_path(review.board), success: "レビューを投稿しました"
    else
      redirect_to board_path(review.board), danger: "レビューが投稿できませんでした"
    end
  end

  def edit
    @review = current_user.reviews.find(params[:id])
    @board = @review.board
  end

  def update
    @review = current_user.reviews.find(params[:id])

    if @review.update(update_review_params)
      redirect_to board_path(@review.board), success: "レビューを更新しました"
    else
      @board = @review.board
      flash.now[:danger] = "レビューの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    review = current_user.reviews.find(params[:id])
    board = review.board
    review.destroy!
    redirect_to board_path(board), success: "レビューを削除しました", status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:workability_rating, :comment).merge(board_id: params[:board_id])
  end

  def update_review_params
    params.require(:review).permit(:workability_rating, :comment)
  end
end

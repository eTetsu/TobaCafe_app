class ReviewsController < ApplicationController
  def create
    review = current_user.reviews.build(review_params)
    if review.save
      redirect_to board_path(review.board), success: "レビューを投稿しました"
    else
      redirect_to board_path(review.board), danger: "レビューが投稿できませんでした"
    end
  end

  private

  def review_params
    params.require(:review).permit(:workability_rating, :comment).merge(board_id: params[:board_id])
  end
end

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :workability_rating, presence: true,
                                 numericality: {
                                   only_integer: true,
                                   greater_than_or_equal_to: 1,
                                   less_than_or_equal_to: 5
                                 }
  validates :comment, length: { maximum: 65_535 }, allow_blank: true
  validates :user_id, uniqueness: { scope: :board_id }
end

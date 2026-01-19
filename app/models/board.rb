class Board < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :nearest_station, presence: true, length: { maximum: 255 }
  # validates :walking_time, presence: true
  validates :opening_hours, length: { maximum: 65_535 }, allow_blank: true
  # validates :small_coffee_price, presence: true
  # validates :seat_capacity, presence: true
  # validates :floor_level, presence: true
  validates :smoking_policy, presence: true
  # validates :website_url,
  #     format: {
  #       with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
  #       message: "は有効なURLを入力してください"
  #     },
  #     allow_blank: true

  enum smoking_policy: {
    smoking_room: 0,
    separate_smoking: 1,
    all_smoking_allowed: 2
  }

  # enum seat_capacity: {
  #   small: 0,
  #   medium: 1,
  #   large: 2
  # }

  # enum floor_level: {
  #   first_floor: 0,
  #   second_floor: 1,
  #   over_third_floor: 2
  # }

  # enum walking_time: {
  #   within_5min: 0,
  #   within_10min: 1,
  #   over_10min: 2
  # }

  def self.ransackable_attributes(auth_object = nil)
    [ "address", "created_at", "id", "nearest_station", "opening_hours", "smoking_policy", "title", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user" ]
  end
end

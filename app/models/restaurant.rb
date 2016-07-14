class Restaurant < ActiveRecord::Base

  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews, dependent: :destroy do
    def build_with_user(attributes = {}, user)
      attributes[:user] ||= user
      build(attributes)
    end
  end

  belongs_to :user

  # def build_review(review_params = {}, current_user)
  #   review = reviews.build(review_params)
  #   review.user = current_user
  #   review
  # end

end

class Restaurant < ActiveRecord::Base

  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews, dependent: :destroy
  
  belongs_to :user

  def build_review(review_params = {}, current_user)
    review = reviews.build(review_params)
    review.user = current_user

    review
  end

end

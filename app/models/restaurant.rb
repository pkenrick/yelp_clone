class Restaurant < ActiveRecord::Base

  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews,
    -> { extending WithUserAssociationExtension },
    dependent: :destroy

  belongs_to :user

  def belongs_to?(current_user)
    user == current_user
  end

  # def build_review(review_params = {}, current_user)
  #   review = reviews.build(review_params)
  #   review.user = current_user
  #   review
  # end

end

class Restaurant < ActiveRecord::Base

  extend WithUserAssociationExtension

  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews,
    -> { extending WithUserAssociationExtension },
    dependent: :destroy

  belongs_to :user

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def belongs_to?(current_user)
    user == current_user
  end

  def average_rating
    ratings = reviews.map{|review| review.rating}
    ratings.reduce(:+).to_f / ratings.length
  end

  # def build_review(review_params = {}, current_user)
  #   review = reviews.build(review_params)
  #   review.user = current_user
  #   review
  # end

end

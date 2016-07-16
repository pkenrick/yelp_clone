require 'spec_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'does not let you submit a name that has already been added' do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  it { is_expected.to belong_to(:user) }

end

describe 'reviews' do
  describe 'build_with_user' do
    let(:user) { User.create email: 'test@test.com' }
    let(:restaurant) { Restaurant.create name: 'Test' }
    let(:review_params) { {rating: 5, thoughts: 'yum'} }

    subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

    it 'builds a review' do
      expect(review).to be_a Review
    end

    it 'builds a review associated with the specified user' do
      expect(review.user).to eq user
    end

  end

end

describe '#average_rating' do

  it 'returns the average rating of all the restaurant\'s reviews' do
    restaurant = Restaurant.create(name: 'KFC')
    restaurant.reviews.create(thoughts: 'ok', rating: '4')
    restaurant.reviews.create(thoughts: 'not so good', rating: '2')
    expect(restaurant.average_rating).to eq(3.0)
  end

end

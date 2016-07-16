require 'rails_helper'

feature 'reviewing' do

  before { Restaurant.create(name: 'KFC', description: 'Nasty chicken') }

  scenario 'user must log in to leave a review' do
    visit '/restaurants'
    click_link 'Review KFC'
    expect(page).to have_content('You need to sign in or sign up before continuing')
    expect(page).to_not have_field('Thoughts')
  end 

  scenario 'user can click add review link and leave a review' do
    sign_up
    leave_review('Far too greasy for my taste', '3')
    expect(current_path).to eq('/restaurants')
    expect(page).to have_content('Far too greasy for my taste')
  end

  scenario 'user can see an average rating of all reviews on the homepage' do
    sign_up
    leave_review('Deliciously greasy', '4')
    click_link 'Sign out'
    sign_up(email: 'bob@bob.com')
    leave_review('To unhealthy', '2')
    expect(page).to have_content('Average rating: 3.0')
  end

end 
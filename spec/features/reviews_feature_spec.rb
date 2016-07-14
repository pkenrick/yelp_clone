require 'rails_helper'

feature 'reviewing' do

  before { Restaurant.create(name: 'KFC', description: 'Nasty chicken') }

  scenario 'user can click add review link and leave a review' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'Far too greasy for my taste'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq('/restaurants')
    expect(page).to have_content('Far too greasy for my taste')
  end

end 
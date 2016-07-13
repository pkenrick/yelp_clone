require 'rails_helper'

feature 'Restaurants' do
  
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content('No restaurants yet')
      expect(page).to have_link('Add a restaurant')
    end 
  end

  context 'restaurants have been added' do
    
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'should display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end

  end

  context 'creating restaurants' do

    scenario 'does not allow a user to add a restaurant if not logged in' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content('You need to sign in or sign up before continuing')
      expect(current_path).to eq('/users/sign_in')
    end

    scenario 'prompts a user to add a new restaurant, then displays the restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content('KFC')
      expect(current_path).to eq('/restaurants')
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        sign_up
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end

    end


  end

  context 'viewing restaurants' do

    let!(:kfc){ Restaurant.create(name: 'KFC') }

    scenario 'can click on a restaurant to see further details' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content('KFC')
      expect(current_path).to eq("/restaurants/#{kfc.id}")
    end

  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

    scenario 'let a user edit a restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq '/restaurants'
    end

  end

  context 'deleting retaurants' do

    before { Restaurant.create(name: 'KFC', description: 'Deep friend goodness') }

    scenario 'let a user delete a restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content('KFC')
      expect(page).to have_content('Restaurant deleted successfully')
      expect(current_path).to eq('/restaurants')
    end

  end



end










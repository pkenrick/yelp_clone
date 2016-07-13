def sign_up
  visit '/users/sign_up'
  fill_in 'Email', with: 'email@email.com'
  fill_in 'Password', with: 'hello11'
  fill_in 'Password confirmation', with: 'hello11'
  click_button 'Sign up'
end
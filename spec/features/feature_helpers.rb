def sign_up(email: 'email@email.com', password: 'hello11', confirm: 'hello11')
  visit '/users/sign_up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: confirm
  click_button 'Sign up'
end
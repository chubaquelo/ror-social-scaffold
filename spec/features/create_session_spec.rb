require 'rails_helper'

RSpec.describe 'Session create and delete', type: :feature do
  let(:user) { User.create(name: 'Johnny Bravo', email: 'johnny@microverse.org', password: '123456789') }

  before(:example) do
    visit new_user_session_path
  end

  scenario 'Correct user login' do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'Incorrect user login' do
    fill_in 'user_email', with: 'someemail@email.com'
    fill_in 'user_password', with: 'password'
    click_on 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'User logout' do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    click_on 'Sign out'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

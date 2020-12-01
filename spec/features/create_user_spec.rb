require 'rails_helper'

RSpec.describe 'session create and delete', type: :feature do
  let(:user) { User.create(name: 'Johnny Bravo', email: 'johnny@microverse.org', password: '123456789') }

  scenario 'login' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
    visit user_path(user.id)
    expect(page).to have_content('Johnny Bravo')
  end

  scenario 'logout' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    click_on 'Sign out'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

require 'rails_helper'

RSpec.describe 'User create', type: :feature do
  let(:user) { User.create(name: 'Johnny Bravo', email: 'johnny@microverse.org', password: '123456789') }

  scenario 'Correct user creation' do
    visit new_user_registration_path
    fill_in 'user_name', with: 'John Doe'
    fill_in 'user_email', with: 'new@user.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end

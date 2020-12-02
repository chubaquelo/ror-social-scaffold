require 'rails_helper'

RSpec.describe 'create friendship', type: :feature do
  let(:user) { User.create(name: 'Johnny Bravo', email: 'johnny@microverse.org', password: '123456789') }
  let!(:seconduser) { User.create(name: 'Dexter', email: 'dexter@microverse.org', password: '123456789') }

  scenario 'Send Friend Request and confirm friendship' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    click_on 'All users'
    click_on 'Add as friend'
    expect(page).to_not have_content('Add as friend')
    expect(page).to have_content('Waiting friend confirmation from Dexter')
    click_on 'Sign out'
    click_on 'Log in'
    fill_in 'user_email', with: seconduser.email
    fill_in 'user_password', with: seconduser.password
    click_on 'Log in'
    click_on 'All users'
    expect(page).to have_content('Johnny Bravo want to be your friend.')
    click_on 'Accept'
    expect(page).to_not have_content('Johnny Bravo want to be your friend.')
    expect(page).to have_content('You are already friends.')
  end
end

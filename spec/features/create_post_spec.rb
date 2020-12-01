require 'rails_helper'

RSpec.describe 'post creation', type: :feature do
  let(:user) { User.create(name: 'Johnny Bravo', email: 'johnny@microverse.org', password: '123456789') }

  scenario 'create post' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    fill_in 'post_content', with: 'This is a new post for testing.'
    click_on 'Save'
    expect(page).to have_content('This is a new post for testing.')
  end

end

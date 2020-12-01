require 'rails_helper'

RSpec.describe 'comment creation', type: :feature do
  let(:user) { User.create(name: 'Johnny Bravo', email: 'johnny@microverse.org', password: '123456789') }

  scenario 'create comment' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    fill_in 'post_content', with: 'This is a new post for testing.'
    click_on 'Save'
    fill_in 'comment_content', with: 'This is a new comment for testing.'
    click_on 'Comment'
    expect(page).to have_content('Johnny Bravo: This is a new comment for testing.')
  end
end

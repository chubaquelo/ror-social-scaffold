require 'rails_helper'

RSpec.describe 'Give a like', type: :feature do
  let(:user) { User.create(name: 'Johnny Bravo', email: 'johnny@microverse.org', password: '123456789') }

  scenario 'Give a like and dislike' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    fill_in 'post_content', with: 'This is a new post for testing.'
    click_on 'Save'
    click_on 'Like!'
    expect(page).to_not have_content('Like!')
    expect(page).to have_content('Dislike!')
    click_on 'Dislike!'
    expect(page).to_not have_content('Dislike!')
    expect(page).to have_content('Like!')
  end
end

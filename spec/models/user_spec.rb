require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Create a user' do
    subject { User.create(name: 'Carlos', email: 'carlos@microverse.org', password: '123456789') }

    it 'change the count of users by one' do
      expect { subject }.to change { User.count }.by(1)
    end
    it 'return Carlos' do
      expect(subject.name).to eq('Carlos')
    end
    it 'email have email format' do
      expect(subject.email).to match(/[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/)
    end
    it 'username length is less than 20' do
      expect(subject.name.length).to be < 20
    end
  end

  describe 'User associations' do
    it 'have many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end
    it 'have many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
    end
    it 'have many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end
    it 'have many friendships' do
      user = User.reflect_on_association(:friendships)
      expect(user.macro).to eq(:has_many)
    end
    it 'have many inverse_friendships' do
      user = User.reflect_on_association(:inverse_friendships)
      expect(user.macro).to eq(:has_many)
    end
  end
end

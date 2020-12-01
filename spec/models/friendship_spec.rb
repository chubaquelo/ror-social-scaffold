require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Create a like' do
    let(:testuser) { User.create(name: 'Carlos', email: 'carlos@microverse.org', password: '123456789') }
    let(:testuser2) { User.create(name: 'Ricardo', email: 'ricardo@microverse.org', password: '987654321') }
    subject {Friendship.create(user_id: testuser.id, friend_id: testuser2.id, confirmed: true)}

    it 'change the count of friendship by one' do
      expect { subject }.to change { Friendship.count }.by(1)
    end
  end

  describe 'frienship associations' do
    it 'belongs to a user' do
      friendship = Friendship.reflect_on_association(:user)
      expect(friendship.macro).to eq(:belongs_to)
    end
    it 'belongs to friend' do
      friendship = Friendship.reflect_on_association(:user)
      expect(friendship.macro).to eq(:belongs_to)
    end
  end
end
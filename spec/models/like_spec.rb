require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Create a like' do
    let(:testuser) { User.create(name: 'Carlos', email: 'carlos@microverse.org', password: '123456789') }
    let(:testpost) { Post.create(user_id: testuser.id, content: 'Post content') }
    subject { Like.create(user_id: testuser.id, post_id: testpost.id) }

    it 'change the count of like by one' do
      expect { subject }.to change { Like.count }.by(1)
    end
  end

  describe 'Like associations' do
    it 'belongs to a user' do
      like = Like.reflect_on_association(:user)
      expect(like.macro).to eq(:belongs_to)
    end
    it 'belongs to post' do
      like = Like.reflect_on_association(:post)
      expect(like.macro).to eq(:belongs_to)
    end
  end
end

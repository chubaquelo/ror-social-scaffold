require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Create a comment' do
    let(:testuser) { User.create(name: 'Carlos', email: 'carlos@microverse.org', password: '123456789') }
    let(:testpost) { Post.create(user_id: testuser.id, content: 'Post content') }
    subject { Comment.create(user_id: testuser.id, post_id: testpost.id, content: 'comment content') }

    it 'change the count of comments by one' do
      expect { subject }.to change { Comment.count }.by(1)
    end
    it 'comment content should be text' do
      expect(subject.content).to_not be_an_instance_of(Numeric)
    end
    it 'content length should be less than 200' do
      expect(subject.content.length).to be < 200
    end
  end

  describe 'Comment associations' do
    it 'belongs to a user' do
      comment = Comment.reflect_on_association(:user)
      expect(comment.macro).to eq(:belongs_to)
    end
    it 'belongs to post' do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eq(:belongs_to)
    end
  end
end

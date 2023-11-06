require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Index' do
    before(:each) do
      User.create(id: 1, name: 'user1', bio: 'This is the bio for user1',
                  photo: 'link')
      User.create(id: 2, name: 'user2', bio: 'This is the bio for user2',
                  photo: 'link')
    end

    it 'username of users present' do
      expect(page).to have_content('user1')
      expect(page).to have_content('user2')
    end
end
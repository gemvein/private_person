shared_context 'users support' do
  let!(:stranger) { FactoryGirl.create(:user) }
  let!(:following_user) { FactoryGirl.create(:user) }
  let!(:followed_user) { FactoryGirl.create(:user) }
  let!(:follower_user) { FactoryGirl.create(:user) }
  let!(:following_of_following_user) { FactoryGirl.create(:user) }
  let!(:follower_of_follower_user) { FactoryGirl.create(:user) }

  before do
    following_user.follow followed_user
    followed_user.follow following_user
    follower_user.follow followed_user
    follower_of_follower_user.follow follower_user
    following_user.follow following_of_following_user

    following_user.reload
    followed_user.reload
    follower_user.reload
    follower_of_follower_user.reload
    following_of_following_user.reload
  end
end
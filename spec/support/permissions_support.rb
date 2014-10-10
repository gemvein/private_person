shared_context 'permissions support' do
  include_context 'users support'
  let!(:following_page) { FactoryGirl.create(:page, :user => followed_user) }
  let!(:follower_page) { FactoryGirl.create(:page, :user => followed_user) }
  let!(:follower_of_follower_page) { FactoryGirl.create(:page, :user => followed_user) }
  let!(:following_of_following_page) { FactoryGirl.create(:page, :user => followed_user) }
  let!(:public_page) { FactoryGirl.create(:page, :user => followed_user) }
  let!(:forbidden_page) { FactoryGirl.create(:page, :user => followed_user) }
  let!(:none_page) { FactoryGirl.create(:page, :user => followed_user) }
  let!(:unmentioned_page) { FactoryGirl.create(:page, :user => followed_user) }

  let!(:general_permission) { FactoryGirl.create(:permission, :permissor => followed_user, :permissible_type => 'Page', :permissible_id => nil, :relationship_type => 'following_users') }
  let!(:following_users_permission)  { FactoryGirl.create(:permission, :permissor => followed_user, :permissible => following_page, :relationship_type => 'following_users') }
  let!(:user_followers_permission)  { FactoryGirl.create(:permission, :permissor => followed_user, :permissible => follower_page, :relationship_type => 'user_followers') }
  let!(:follower_of_followers_permission)  { FactoryGirl.create(:permission, :permissor => followed_user, :permissible => follower_of_follower_page, :relationship_type => 'follower_of_followers') }
  let!(:following_of_followings_permission)  { FactoryGirl.create(:permission, :permissor => followed_user, :permissible => following_of_following_page, :relationship_type => 'following_of_followings') }
  let!(:public_permission)  { FactoryGirl.create(:permission, :permissor => followed_user, :permissible => public_page, :relationship_type => 'public') }
  let!(:forbidden_permission)  { FactoryGirl.create(:permission, :permissor => followed_user, :permissible => forbidden_page, :relationship_type => 'forbidden') }
  let!(:none_permission)  { FactoryGirl.create(:permission, :permissor => followed_user, :permissible => none_page, :relationship_type => 'none') }

  let!(:permissions) { PrivatePerson::Permission.all }
  let!(:wildcards) { PrivatePerson::Permission.by_wildcard('Page') }

end
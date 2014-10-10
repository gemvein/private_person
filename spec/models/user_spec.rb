require 'spec_helper'

describe User do

  describe 'acts_as_permitted' do
    it { should have_many(:permissions_as_permissor) }
    it { should have_many(:permissibles) }

    context 'Instance Methods' do

      describe '#relationship_to' do
        include_context 'users support'
        context 'when following and follower' do
          subject { following_user.relationship_to(followed_user) }
          it { should eq 'following_users' }
        end
        context 'when following and follower: vice versa' do
          subject { followed_user.relationship_to(following_user) }
          it { should eq 'following_users' }
        end
        context 'when follower' do
          subject { follower_user.relationship_to(followed_user) }
          it { should eq 'user_followers' }
        end
        context 'when following_of_following' do
          subject { following_of_following_user.relationship_to(followed_user) }
          it { should eq 'following_of_followings' }
        end
        context 'when follower_of_follower' do
          subject { follower_of_follower_user.relationship_to(followed_user) }
          it { should eq 'follower_of_followers' }
        end
        context 'when stranger' do
          subject { stranger.relationship_to(followed_user) }
          it { should eq 'public' }
        end
      end
      describe '#permissions_by' do
        include_context 'permissions support'
        context 'when following' do
          subject { following_user.permissions_by(followed_user) }
          it { should be_an ActiveRecord::Relation }
          its(:first) { should be_a PrivatePerson::Permission }
          it { should include following_users_permission }
          it { should include public_permission }
        end
        context 'when follower' do
          subject { follower_user.permissions_by(followed_user) }
          it { should be_an ActiveRecord::Relation }
          its(:first) { should be_a PrivatePerson::Permission }
          it { should include user_followers_permission }
        end
        context 'when following_of_followings' do
          subject { following_of_following_user.permissions_by(followed_user) }
          it { should be_an ActiveRecord::Relation }
          its(:first) { should be_a PrivatePerson::Permission }
          it { should include following_of_followings_permission }
        end
        context 'when follower_of_follower' do
          subject { follower_of_follower_user.permissions_by(followed_user) }
          it { should be_an ActiveRecord::Relation }
          its(:first) { should be_a PrivatePerson::Permission }
          it { should include follower_of_followers_permission }
        end
      end
      describe '#is_permitted?' do
        include_context 'permissions support'
        context 'when following' do
          subject { following_user.is_permitted?(followed_user, following_page) }
          it { should be true }
        end
        context 'when follower' do
          subject { follower_user.is_permitted?(followed_user, follower_page) }
          it { should be true }
        end
        context 'when following_of_followings' do
          subject { following_of_following_user.is_permitted?(followed_user, following_of_following_page) }
          it { should be true }
        end
        context 'when follower_of_follower' do
          subject { follower_of_follower_user.is_permitted?(followed_user, follower_of_follower_page) }
          it { should be true }
        end
        context 'when unmentioned but permitted by type' do
          subject { following_user.is_permitted?(followed_user, unmentioned_page) }
          it { should be true }
        end
        context 'when public' do
          subject { following_user.is_permitted?(followed_user, public_page) }
          it { should be true }
        end
        context 'when none' do
          subject { following_user.is_permitted?(followed_user, none_page) }
          it { should be false }
        end
        context 'otherwise' do
          subject { following_user.is_permitted?(followed_user, forbidden_page) }
          it { should be false }
        end
      end
    end
  end

  describe 'acts_as_permissor' do
    include_context 'users support'
    include_context 'permissor support'
    context 'Instance Methods' do

      describe '#permits' do
        context 'when overriding public' do
          before do
            public_user.permit! 'none', public_user_page
          end
          subject { stranger.is_permitted? public_user, public_user_page }
          it { should be false }
        end
        context 'when overriding none' do
          before do
            private_user.permit! 'public', private_user_page
          end
          subject { stranger.is_permitted? private_user, private_user_page }
          it { should be true }
        end
      end
      describe '#wildcard_permits' do
         # the support files already ran the heavy lifting,
         # so if they worked we're golden
        context 'with none' do
          subject { stranger.is_permitted? private_user, private_user_page }
          it { should be false }
        end
        context 'with public' do
          subject { stranger.is_permitted? public_user, public_user_page }
          it { should be true }
        end
      end
    end
  end
end

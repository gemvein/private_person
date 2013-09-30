class User < ActiveRecord::Base
  acts_as_permissor :of => [:following_users, :user_followers, :following_of_followings, :follower_of_followers], :class_name => 'User'

  def follow(user)
    ChalkDust.subscribe(self, :to => user)
  end

  def following_users
    ChalkDust.publishers_of(self)
  end

  def user_followers
    ChalkDust.subscribers_of(self)
  end

  def following_of_followings
    ids = []
    for user in following_users
      ids |= user.following_users
    end
    User.where(:id => ids)
  end

  def follower_of_followers
    ids = []
    for user in user_followers
      ids |= user.user_followers
    end
    User.where(:id => ids)
  end
end

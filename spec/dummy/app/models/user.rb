class User < ActiveRecord::Base
  acts_as_follower
  acts_as_followable

  acts_as_permissor :of => [:following_users, :user_followers, :following_of_followings, :follower_of_followers], :class_name => 'User'

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

  def is_following_user_of?(item)
    self.followed_by?(item)
  end

  def is_user_follower_of?(item)
    item.followed_by?(self)
  end
end

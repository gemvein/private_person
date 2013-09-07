class Page < ActiveRecord::Base
  acts_as_permissible :by => :user
  belongs_to :user
end

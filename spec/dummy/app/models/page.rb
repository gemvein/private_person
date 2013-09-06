class Page < ActiveRecord::Base
  acts_as_permissible
  belongs_to :user
end

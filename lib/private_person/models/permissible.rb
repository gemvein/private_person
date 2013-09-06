module PrivatePerson
  module Permissible
    def acts_as_permissible
      class_eval do
        has_many :permissions, :as => :permissible
      end
    end
  end
end
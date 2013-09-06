module PrivatePerson
  module Permissor
    def acts_as_permissor
      class_eval do
        has_many :permissions, :as => :permissor
      end
    end
  end
end
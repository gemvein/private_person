module PrivatePerson
  module Permissible
    def acts_as_permissible(params = {})
      if params[:by].nil?
        raise 'Called acts_as_permissible, but without a :by parameter.'
      end
      class_attribute :by
      self.by = params[:by]

      class_eval do
        has_many :permissions, :as => :permissible
        has_many :permissors, :through => :permissions, :as => :permissor
      end
    end
  end
end
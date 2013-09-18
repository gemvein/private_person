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
        has_one :permissor, :through => :permissions, :as => :permissor

        def is_public?
          !permissions.by_relationship_type(nil).empty?
        end
      end
    end
  end
end
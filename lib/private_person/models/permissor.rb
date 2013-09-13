module PrivatePerson
  module Permissor
    def acts_as_permissor(params = {})
      if params[:of].nil?
        raise 'Called acts_as_permissor, but without an :of parameter.'
      end
      class_attribute :of
      self.of = params[:of]
      class_name = params[:class_name] || params[:of].to_s.classify
      class_name.constantize.acts_as_permitted
      class_eval do
        has_many :permissions, :as => :permissor
        has_many :permissibles, :through => :permissions, :as => :permissible

        def permits(whom, what)
          existing = self.permissions.find_all_by_relationship_type(whom).find_all_by_permissible(what)

          if existing.empty?
            self.permissions.create({:relationship_type => whom, :permissible => what})
          end
        end

        def wildcard_permits(whom, what)
          existing = self.permissions.find_all_by_relationship_type(whom).find_all_by_permissible_type(what)

          if existing.empty?
            self.permissions.create({:relationship_type => whom, :permissible_type => what})
          end
        end
      end
    end
  end
end
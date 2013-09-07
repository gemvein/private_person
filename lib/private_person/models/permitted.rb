module PrivatePerson
  module Permitted
    def acts_as_permitted
      class_eval do
        def is_permitted?(permissor, permissible)
          if Permission.find_all_by_permissible(permissible).blocked.exists?
            return false
          end
          wildcards = permissions_by(permissor).find_all_by_wildcard(permissible.class.name).legitimate
          if wildcards.exists?
            return true
          end
          permissions = permissions_by(permissor).find_all_by_permissible(permissible).legitimate
          if permissions.exists?
            return true
          end
          return false
        end

        def permissions_by(permissor)
          Permission.find_all_by_permissor(permissor).find_all_by_relationship_type(relationship_to(permissor))
        end

        def relationship_to(permissor)
          # First check for an efficient method
          for relationship_method in permissor.class.of
            is_method = ('is_' + relationship_method.to_s.singularize + '_of?').to_sym
            if respond_to?(is_method) and self.send(is_method, permissor)
              return relationship_method.to_s
            end
          end
          # Then check for a slow method
          for relationship_method in permissor.class.of
            relationship_members = permissor.send(relationship_method.to_sym)
            if relationship_members.exists?(:id => self.id)
              return relationship_method.to_s
            end
          end
          return nil
        end
      end
    end
  end
end
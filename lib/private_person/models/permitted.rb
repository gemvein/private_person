module PrivatePerson
  module Permitted
    def acts_as_permitted
      class_eval do
        def is_permitted?(permissor, permissible)
          if permissible.nil?
            raise 'Called is_permitted? on nil. Does not compute. Preparing to self destruct.'
          end
          unless Permission.by_permissible(permissible).blocked.empty?
            return false
          end
          wildcards = permissions_by(permissor).by_wildcard(permissible.class.name).legitimate
          if wildcards.present?
            return true
          end
          permissions = permissions_by(permissor).by_permissible(permissible).legitimate
          if permissions.present?
            return true
          end
          return false
        end

        def permissions_by(permissor)
          Permission.by_permissor(permissor).by_relationship_type(relationship_to(permissor))
        end

        def relationship_to(permissor)
          # First make sure we're not a new user
          if self.new_record?
            return 'public'
          end
          # Next check for an efficient method
          for relationship_method in permissor.class.of
            is_method = ('is_' + relationship_method.to_s.singularize + '_of?').to_sym
            if respond_to?(is_method) and self.send(is_method, permissor)
              return relationship_method.to_s
            end
          end
          # Then check for a slow method
          for relationship_method in permissor.class.of
            relationship_members = permissor.send(relationship_method.to_sym)
            if relationship_members.present? and relationship_members.include? self
              return relationship_method.to_s
            end
          end
          return 'public'
        end
      end
    end
  end
end
module PrivatePerson
  class Permission < ActiveRecord::Base
    belongs_to :permissor, :polymorphic => true
    belongs_to :permissible, :polymorphic => true

    def self.by_permissor(permissor)
      where("permissor_type = ? AND permissor_id = ?", permissor.class.name, permissor.id)
    end

    def self.by_permissible(permissible)
      where("permissible_type = ? AND permissible_id = ?", permissible.class.name, permissible.id)
    end

    def self.by_wildcard(permissible_type)
      where(:permissible_type => permissible_type, :permissible_id => nil)
    end

    def self.by_relationship_type(relationship_type)
      if relationship_type == 'public' or relationship_type.nil?
        return where("relationship_type = 'public'")
      end
      if(self.permissible_types.include? relationship_type)
        return where("relationship_type = ? OR relationship_type = 'public'", relationship_type)
      end
      return where(0)
    end

    def self.blocked
      where('NOT(relationship_type IN (?))', self.permissible_types)
    end

    def self.legitimate
      where('relationship_type IN (?)', self.permissible_types)
    end

    def self.permissible_types
      permissible_types = ['public']
      for record in self.group('permissor_type').group('permissor_id')
        permissor = record.permissor_type.constantize.find(record.permissor_id)
        unless permissor.nil?
          for method in permissor.class.of
            permissible_types << method.to_s
          end
        end
      end
      permissible_types.compact
    end

    def existing_types
      existing_types = ['public']
      for method in permissor.class.of
        existing_types << method.to_s
      end
      existing_types
    end
  end
end
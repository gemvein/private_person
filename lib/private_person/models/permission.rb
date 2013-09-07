class Permission < ActiveRecord::Base
  belongs_to :permissor, :polymorphic => true
  belongs_to :permissible, :polymorphic => true

  attr_accessible :permissible, :permissible_type, :permissible_id, :relationship_type
  validates_presence_of :permissor, :permissible_type, :relationship_type

  def self.find_all_by_permissor(permissor)
    where("permissor_type = ? AND permissor_id = ?", permissor.class.name, permissor.id)
  end

  def self.find_all_by_permissible(permissible)
    where("permissible_type = ? AND permissible_id = ?", permissible.class.name, permissible.id)
  end

  def self.find_all_by_wildcard(permissible_type)
    where(:permissible_type => permissible_type, :permissible_id => nil)
  end

  def self.find_all_by_relationship_type(relationship_type)
    if relationship_type == 'public'
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
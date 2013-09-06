class Permission < ActiveRecord::Base
  belongs_to :permissor, :polymorphic => true
  belongs_to :permissible, :polymorphic => true

  attr_accessible :permissible, :permissible_type, :permissible_id, :relationship_type
  validates_presence_of :permissor, :permissible_type, :relationship_type
end
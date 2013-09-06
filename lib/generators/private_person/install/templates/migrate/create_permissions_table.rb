class CreatePermissionsTable < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.string      :permissor_type
      t.integer     :permissor_id
      t.string      :permissible_type
      t.integer     :permissible_id
      t.string      :relationship_type
      t.timestamps
    end
  end
  def self.down
    drop_table :permissions
  end
end
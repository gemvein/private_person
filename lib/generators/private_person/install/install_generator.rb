module PrivatePerson
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    require File.expand_path('../../utils', __FILE__)
    include Generators::Utils
    include Rails::Generators::Migration
    
    def hello
      output "With PrivatePerson, you can put your users in control of their own privacy policies.", :magenta
    end

    def add_migrations
      unless ActiveRecord::Base.connection.table_exists? 'permissions'
        migration_template 'migrate/create_permissions_table.rb', 'db/migrate/create_permissions_table.rb' rescue output $!.message
      end
    end
    
    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
  end
end
module PrivatePerson
  require 'rails'
  require 'private_person/version'
  require 'private_person/models/permissor'
  require 'private_person/models/permission'
  require 'private_person/models/permissible'
  require 'private_person/models/permitted'
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend PrivatePerson::Permitted
  ActiveRecord::Base.extend PrivatePerson::Permissor
  ActiveRecord::Base.extend PrivatePerson::Permissible
end
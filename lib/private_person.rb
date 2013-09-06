module PrivatePerson
  require 'rails'
  require 'private_person/version'
  require 'private_person/models/permissor'
  require 'private_person/models/permission'
  require 'private_person/models/permissible'
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend PrivatePerson::Permissor
  ActiveRecord::Base.extend PrivatePerson::Permissible
end
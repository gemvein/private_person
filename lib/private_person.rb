module PrivatePerson
  require 'rails'
  require 'private_person/version'
  require 'private_person/models/permission'
  require 'private_person/extensions/acts_as_permissor'
  require 'private_person/extensions/acts_as_permissible'
  require 'private_person/extensions/acts_as_permitted'

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.send(:include, ActsAsPermitted)
    ActiveRecord::Base.send(:include, ActsAsPermissor)
    ActiveRecord::Base.send(:include, ActsAsPermissible)
  end
end
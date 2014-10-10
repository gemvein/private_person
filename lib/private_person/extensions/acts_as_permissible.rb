module PrivatePerson
  module ActsAsPermissible

    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_permissible(params = {})
        if params[:by].nil?
          raise 'Called acts_as_permissible, but without a :by parameter.'
        end
        class_attribute :by
        self.by = params[:by]

        has_many :permissions, :as => :permissible, :class_name => 'PrivatePerson::Permission'
        has_many :permissors, :through => :permissions, :as => :permissible

        send :include, InstanceMethods
      end
    end

    module InstanceMethods
      def is_public?
        !permissions.by_relationship_type(nil).empty?
      end
    end
  end
end
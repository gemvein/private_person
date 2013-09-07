module PrivatePerson
  module Permissor
    def acts_as_permissor(params = {})
      if params[:of].nil?
        raise 'Called acts_as_permissor, but without an :of parameter.'
      end
      class_attribute :of
      self.of = params[:of]
      class_name = params[:class_name] || params[:of].to_s.classify
      class_name.constantize.acts_as_permitted
      class_eval do
        has_many :permissions, :as => :permissor
        has_many :permissibles, :through => :permissions, :as => :permissible
      end
    end
  end
end
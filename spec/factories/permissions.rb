FactoryGirl.define do
  factory :permission, class: PrivatePerson::Permission do
    relationship_type 'none'
    permissible
    permissor
  end
end
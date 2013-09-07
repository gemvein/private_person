FactoryGirl.define do
  factory :permission do
    relationship_type 'none'
    permissible
    permissor
  end
end
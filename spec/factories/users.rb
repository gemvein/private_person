FactoryGirl.define do
  factory :user, :aliases => [:permissor] do
    sequence(:nickname) {|n| "person#{n}" }
  end
end
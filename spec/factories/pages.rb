FactoryGirl.define do
  factory :page, :aliases => [:permissible] do
    sequence(:title) {|n| "page#{n}" }
    body 'Lorem Ipsum, baby'
    user
  end
end
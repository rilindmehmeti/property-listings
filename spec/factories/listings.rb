FactoryBot.define do
  factory :listing do
    sequence(:title) { |i| "Listing##{i}"}
  end
end

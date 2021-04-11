FactoryBot.define do
  factory :role do
    trait :staff do
      status {"staff"}
    end

    trait :admin do
      status {"admin"}
    end
  end
end

FactoryBot.define do
  factory :event do
    description { "My first day at work!" }
    visible {true}
    clock_in { Time.current }
    clock_out { Time.current + 5.hours }
    user_profession
  end
end

FactoryBot.define do
  factory :appointment do
    association :doctor
    association :patient
    status { "open" }
    recommendation { "Take two pills daily" }
  end

  factory :closed_appointment, parent: :appointment do
    status { "closed" }
    recommendation { "Complete rest" }
  end

end



FactoryBot.define do
  factory :application_model, aliases: [:application] do
    association :job

    candidate_name { 'Jane Smith' }
  end
end

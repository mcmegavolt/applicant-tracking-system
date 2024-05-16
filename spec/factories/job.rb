FactoryBot.define do
  factory :job_model, aliases: [:job] do
    title { 'Software Developer' }
    description { 'Awesome job' }
  end
end

FactoryBot.define do
  factory :application_event, class: 'Application::Event' do
    application

    factory :application_event_hired, class: 'Application::Event::Hired' do
      type { 'Application::Event::Hired' }
      hire_date { Time.now }
    end

    factory :application_event_interview, class: 'Application::Event::Interview' do
      type { 'Application::Event::Interview' }
      interview_date { Time.now }
    end

    factory :application_event_note, class: 'Application::Event::Note' do
      type { 'Application::Event::Note' }
      content { 'Some notes...' }
    end

    factory :application_event_rejected, class: 'Application::Event::Rejected' do
      type { 'Application::Event::Rejected' }
    end
  end
end

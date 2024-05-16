require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Applications', type: :request do
  describe 'GET /applications' do
    let(:job) { FactoryBot.create(:job, title: 'Software Developer') }
    let(:application) { FactoryBot.create(:application, job:, candidate_name: 'John Doe') }

    let!(:job_event_deactivated) { FactoryBot.create(:job_event_deactivated, job:) }
    let!(:job_event_activated) { FactoryBot.create(:job_event_activated, job:) }

    let!(:application_event_note) { FactoryBot.create(:application_event_note, application: application) }
    let!(:application_event_interview) { FactoryBot.create(:application_event_interview, application: application) }

    let(:user) { FactoryBot.create(:user) }
    let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }

    it 'returns a successful response' do
      get('/applications', headers:)
      expect(response).to have_http_status(:success)
    end

    it 'returns applications data' do
      get('/applications', headers:)

      expect(JSON.parse(response.body)['data'].size).to eq 1
    end

    it 'returns correct attributes for each application' do
      get('/applications', headers:)

      json_data = JSON.parse(response.body)['data'].first

      expect(json_data).to match(
        {
          id: application.id.to_s,
          type: 'application',
          attributes: {
            job_name: job.title,
            candidate_name: application.candidate_name,
            status: 'interview',
            notes_count: 1,
            last_interview_date: application_event_interview.interview_date.strftime('%Y-%m-%d')
          },
          relationships: {
            job: {
              data: {
                id: job.id.to_s,
                type: 'job'
              }
            }
          }
        }.with_indifferent_access
      )
    end
  end
end

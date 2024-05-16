require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Jobs', type: :request do
  describe 'GET /jobs' do
    let(:job) { FactoryBot.create(:job, title: 'Software Developer') }
    let(:application_hired) { FactoryBot.create(:application, job:, candidate_name: 'John Doe') }
    let(:application_interview) { FactoryBot.create(:application, job:, candidate_name: 'Alex Pon') }
    let(:application_rejected) { FactoryBot.create(:application, job:, candidate_name: 'Megan Fox') }

    let!(:job_event_activated) { FactoryBot.create(:job_event_activated, job:) }

    let!(:application_event_hired) { FactoryBot.create(:application_event_hired, application: application_hired) }
    let!(:application_event_rejected) { FactoryBot.create(:application_event_rejected, application: application_rejected) }
    let!(:application_event_interview) { FactoryBot.create(:application_event_interview, application: application_interview) }

    let(:user) { FactoryBot.create(:user) }
    let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }

    it 'returns a successful response' do
      get('/jobs', headers:)
      expect(response).to have_http_status(:success)
    end

    it 'returns applications data' do
      get('/jobs', headers:)

      expect(JSON.parse(response.body)['data'].size).to eq 1
    end

    it 'returns correct attributes for each application' do
      get('/jobs', headers:)

      json_data = JSON.parse(response.body)['data'].first

      expect(json_data).to match(
        {
          id: job.id.to_s,
          type: 'job',
          attributes: {
            name: job.title,
            status: 'activated',
            hired_candidates_count: 1,
            rejected_candidates_count: 1,
            ongoing_applications_count: 1
          }
        }.with_indifferent_access
      )
    end
  end
end

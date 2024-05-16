class ApplicationSerializer
  include JSONAPI::Serializer

  attributes :job_name, :candidate_name, :status, :notes_count

  attribute :last_interview_date do |object|
    object.last_interview_date&.to_date&.strftime('%Y-%m-%d')
  end

  belongs_to :job
end
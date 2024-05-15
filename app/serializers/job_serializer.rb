class JobSerializer
  include JSONAPI::Serializer

  attributes :name, :status, :hired_candidates_count, :rejected_candidates_count, :ongoing_applications_count
end
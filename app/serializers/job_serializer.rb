class JobSerializer
  include JSONAPI::Serializer

  set_type :job
  set_id :id
  attributes :name, :status, :hired_candidates_count, :rejected_candidates_count, :ongoing_applications_count
end
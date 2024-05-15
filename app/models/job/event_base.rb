module Job
  class EventBase < ApplicationRecord
    self.table_name = 'job_events'

    belongs_to :job, class_name: 'JobModel'
  end
end
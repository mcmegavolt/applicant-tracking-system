class JobModel < ApplicationRecord
  self.table_name = 'jobs'

  has_many :applications, dependent: :destroy
  has_many :events, dependent: :destroy, class_name: 'Job::EventBase', foreign_key: :job_id

  validates_presence_of :title, :description
end

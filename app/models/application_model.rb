class ApplicationModel < ApplicationRecord
  self.table_name = 'applications'

  belongs_to :job, class_name: 'JobModel'
  has_many :events, dependent: :destroy, class_name: 'Application::EventBase', foreign_key: :application_id

  validates_presence_of :candidate_name
end

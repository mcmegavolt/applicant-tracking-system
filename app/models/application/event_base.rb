module Application
  class EventBase < ApplicationRecord
    self.table_name = 'application_events'

    belongs_to :application, class_name: 'ApplicationModel'
  end
end
module Application
  module Event
    class Interview < Application::EventBase
      validates_presence_of :interview_date
    end
  end
end
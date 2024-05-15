module Application
  module Event
    class Hired < Application::EventBase
      validates_presence_of :hire_date
    end
  end
end
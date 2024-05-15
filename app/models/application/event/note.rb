module Application
  module Event
    class Note < Application::EventBase
      validates_presence_of :content
    end
  end
end
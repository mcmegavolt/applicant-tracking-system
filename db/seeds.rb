# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

job1 = JobModel.create(title: 'Software Engineer', description: 'Develop awesome software')
job2 = JobModel.create(title: 'Data Scientist', description: 'Analyze big data')

application1 = ApplicationModel.create(candidate_name: 'John Doe', job: job1)
application2 = ApplicationModel.create(candidate_name: 'Jane Smith', job: job2)

Application::Event::Interview.create(application: application1, interview_date: Time.now)
Application::Event::Hired.create(application: application1, hire_date: Time.now)

Application::Event::Interview.create(application: application2, interview_date: Time.now)
Application::Event::Rejected.create(application: application2)
Application::Event::Note.create(content: 'Some notes...', application: application2)

Job::Event::Activated.create(job: job1)
Job::Event::Deactivated.create(job: job2)

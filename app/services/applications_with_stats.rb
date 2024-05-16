class ApplicationsWithStats < ApplicationService
  def call
    ActiveRecord::Base.connection.execute(all_with_stats_query).map { |app| OpenStruct.new(app) }
  end

  private

  def all_with_stats_query
    <<-SQL
      SELECT
      a.id,
      a.job_id,
      a.candidate_name,
      j.title AS job_name,
      CASE
        WHEN MAX(CASE WHEN ae.type = 'Application::Event::Interview' THEN 1 ELSE 0 END) = 1 THEN 'interview'
        WHEN MAX(CASE WHEN ae.type = 'Application::Event::Hired' THEN 1 ELSE 0 END) = 1 THEN 'hired'
        WHEN MAX(CASE WHEN ae.type = 'Application::Event::Rejected' THEN 1 ELSE 0 END) = 1 THEN 'rejected'
        ELSE 'applied'
      END AS status,
      (SELECT COUNT(*) FROM application_events ae WHERE ae.application_id = a.id AND ae.type = 'Application::Event::Note') AS notes_count,
      (SELECT MAX(ae.interview_date) FROM application_events ae WHERE ae.application_id = a.id AND ae.type = 'Application::Event::Interview') AS last_interview_date
      FROM
        jobs j
      INNER JOIN
        applications a ON j.id = a.job_id
      LEFT JOIN
        (
          SELECT
            application_id,
            type,
            interview_date,
            MAX(created_at) AS last_event_date
          FROM
            application_events
          GROUP BY
            application_id
        ) ae ON a.id = ae.application_id
      INNER JOIN
        (
          SELECT
            job_id
          FROM
            job_events
          WHERE
            type = 'Job::Event::Activated'
          GROUP BY
            job_id
        ) je ON j.id = je.job_id
      GROUP BY
        j.title, a.candidate_name;
    SQL
  end
end
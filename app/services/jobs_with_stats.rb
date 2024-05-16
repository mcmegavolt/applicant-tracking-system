class JobsWithStats < ApplicationService
  def call
    ActiveRecord::Base.connection.execute(all_with_stats_query).map { |job| OpenStruct.new(job) }
  end

  private

  def all_with_stats_query
    <<-SQL
      SELECT
        j.id,
        j.title AS name,
        CASE
          WHEN MAX(CASE WHEN e.type = 'Job::Event::Activated' THEN 1 ELSE 0 END) = 1 THEN 'activated'
          ELSE 'deactivated'
        END AS status,
        COALESCE(SUM(CASE WHEN ae.type = 'Application::Event::Hired' THEN 1 ELSE 0 END), 0) AS hired_candidates_count,
        COALESCE(SUM(CASE WHEN ae.type = 'Application::Event::Rejected' THEN 1 ELSE 0 END), 0) AS rejected_candidates_count,
        COALESCE(SUM(CASE WHEN ae.type NOT IN ('Application::Event::Hired', 'Application::Event::Rejected') OR ae.type IS NULL THEN 1 ELSE 0 END), 0) AS ongoing_applications_count
      FROM
        jobs j
      LEFT JOIN
        applications a ON j.id = a.job_id
      LEFT JOIN
        (
          SELECT
            application_id,
            type,
            MAX(created_at)
          FROM
            application_events
          WHERE
            type != 'Application::Event::Note'
          GROUP BY
            application_id
        ) ae ON a.id = ae.application_id
      LEFT JOIN
        job_events e ON j.id = e.job_id
      GROUP BY
        j.id, j.title;
    SQL
  end
end
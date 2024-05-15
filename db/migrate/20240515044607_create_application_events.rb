class CreateApplicationEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :application_events do |t|
      t.references :application, null: false, foreign_key: true
      t.datetime :interview_date
      t.datetime :hire_date
      t.text :content

      t.timestamps
    end
  end
end
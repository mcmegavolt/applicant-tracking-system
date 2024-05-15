class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.string :candidate_name
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end

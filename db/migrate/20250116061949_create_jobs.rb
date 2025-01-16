class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.string :location, null: false
      t.integer :job_type, null: false
      t.string :company_name, null: false
      t.date :start_date
      t.date :end_date
      t.string :activities, array: true, default: []
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end

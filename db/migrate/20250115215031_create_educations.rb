class CreateEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :educations do |t|
      t.string :school_name, null: false
      t.string :career, null: false
      t.date :start_date
      t.date :end_date
      t.string :location
      t.string :professional_license
      t.boolean :is_course, default: false
      t.string :relevant_topics, array: true, default: []
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end

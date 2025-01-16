class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :company_name, null: false
      t.string :live_url
      t.string :repository_url, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end

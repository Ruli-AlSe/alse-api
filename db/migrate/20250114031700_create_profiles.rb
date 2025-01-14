class CreateProfiles < ActiveRecord::Migration[6.1]
  def up
    execute <<~SQL
      CREATE TYPE social_media as (
        linkedin varchar,
        facebook varchar,
        instagram varchar,
        github varchar,
        whatsapp varchar,
        x varchar
      );
    SQL
    create_table :profiles do |t|
      t.string :name
      t.string :last_name
      t.string :headliner
      t.text :bio
      t.string :city
      t.string :state
      t.string :country
      t.string :phone_number
      t.string :social_media

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    execute 'DROP TYPE social_media'
    drop_table :profiles
  end
end

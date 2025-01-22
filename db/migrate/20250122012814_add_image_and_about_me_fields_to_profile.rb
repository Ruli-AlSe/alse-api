class AddImageAndAboutMeFieldsToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :image_url, :string
    add_column :profiles, :about_me, :text
  end
end

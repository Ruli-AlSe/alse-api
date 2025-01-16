class AddProfilableToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_reference :profiles, :profilable, polymorphic: true, null: false
    remove_column :profiles, :user_id, :bigint
  end
end

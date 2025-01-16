class RenameProductModelByPost < ActiveRecord::Migration[6.1]
  def change
    rename_table :products, :posts
  end
end

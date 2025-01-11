class RenameStoreModelToCompany < ActiveRecord::Migration[6.1]
  def change
    rename_table :stores, :companies
    rename_column :users, :store_id, :company_id
    rename_column :products, :store_id, :company_id
  end
end

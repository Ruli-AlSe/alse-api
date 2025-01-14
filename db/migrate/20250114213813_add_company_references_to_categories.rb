class AddCompanyReferencesToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :company_id, :integer
    add_index :categories, :company_id
  end
end

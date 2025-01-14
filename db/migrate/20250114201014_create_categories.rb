class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.string :slug

      t.timestamps
    end
    add_column :posts, :category_id, :integer
    add_column :posts, :slug, :string
    add_index :categories, :slug, unique: true
  end
end

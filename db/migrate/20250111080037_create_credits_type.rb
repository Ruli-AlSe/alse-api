class CreateCreditsType < ActiveRecord::Migration[6.1]
  def up
    execute <<~SQL
      CREATE TYPE credits as (
        link_url varchar,
        page_name varchar,
        user_name varchar
      );
    SQL
    rename_column :posts, :name, :title
    rename_column :posts, :description, :content
    remove_column :posts, :price, :float
    add_column :posts, :image_url, :string
    add_column :posts, :credits, :credits
  end

  def down
    rename_column :posts, :title, :name
    rename_column :posts, :content, :description
    add_column :posts, :price, :float
    remove_column :posts, :image_url, :string
    remove_column :posts, :credits, :credits
    execute 'DROP TYPE credits'
  end
end

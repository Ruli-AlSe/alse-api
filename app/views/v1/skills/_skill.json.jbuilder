json.extract! skill, :id, :name, :icon_url, :level, :created_at, :updated_at
json.category skill.category, partial: 'v1/categories/category', as: :category

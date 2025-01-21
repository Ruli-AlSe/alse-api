json.extract! skill, :id, :name, :icon_url, :level
json.category skill.category, partial: 'v1/categories/category', as: :category

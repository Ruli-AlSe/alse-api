json.extract! profile, :id, :name, :last_name, :image_url, :about_me, :headliner, :bio, :city, :state, :country, :phone_number, :social_media
json.education profile.educations, partial: 'v1/educations/education', as: :education
json.jobs profile.jobs, partial: 'v1/jobs/job', as: :job
json.competences Skill.grouped_by_category(profile.skills).each do |category, skills|
  json.category_title category
  json.skills skills, partial: 'v1/skills/skill', as: :skill
end

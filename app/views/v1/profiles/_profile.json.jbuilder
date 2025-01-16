json.extract! profile, :id, :name, :last_name, :headliner, :bio, :city, :state, :country, :phone_number, :social_media
json.skills profile.skills, partial: 'v1/skills/skill', as: :skill
json.education profile.educations, partial: 'v1/educations/education', as: :education
json.jobs profile.jobs, partial: 'v1/jobs/job', as: :job

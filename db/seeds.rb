# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Skill.destroy_all
Post.destroy_all
Post.with_deleted.each do |post|
  post.really_destroy!
end
Project.destroy_all
Job.destroy_all
Education.destroy_all
Category.destroy_all
Token.destroy_all
Profile.destroy_all
User.destroy_all
Admin.destroy_all
Owner.destroy_all
Company.destroy_all

puts 'All tables cleaned'

admin_company = Company.create(name: 'alse')
admin = Admin.create(email: 'raul@example.com', age: 31, password: '123abc', company_id: admin_company.id)
admin_profile = Profile.create(name: Faker::Name.first_name,
                               last_name: Faker::Name.last_name,
                               image_url: Faker::Avatar.image,
                               about_me: Faker::Lorem.paragraph(sentence_count: 5),
                               headliner: Faker::Job.title,
                               bio: Faker::Lorem.paragraph(sentence_count: 10),
                               city: Faker::Address.city,
                               state: Faker::Address.state,
                               country: Faker::Address.country,
                               phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
                               social_media: "(https://www.linkedin.com/in/ruli-alse/,,,https://github.com/Ruli-AlSe,https://wa.me/#{Faker::PhoneNumber.cell_phone_with_country_code},)",
                               profilable: admin)

puts 'Admin (company, profile) created'

owner_company = Company.create(name: 'Nutrición Abierta')
owner = Owner.create(email: 'eduardo@example.com', age: 32, password: '123abc', company_id: owner_company.id)
owner_profile = Profile.create(name: Faker::Name.first_name,
                               last_name: Faker::Name.last_name,
                               headliner: Faker::Job.title,
                               bio: Faker::Lorem.paragraph(sentence_count: 10),
                               city: Faker::Address.city,
                               state: Faker::Address.state,
                               country: Faker::Address.country,
                               phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
                               social_media: "(https://www.linkedin.com/in/eduardo/,https://www.facebook.com/eduardo/,https://www.instagram.com/eduardo/,,https://wa.me/#{Faker::PhoneNumber.cell_phone_with_country_code},https://www.x.com/eduardo/)",
                               profilable: owner)

puts 'Owner (company, profile) created'

admin_categories = []
owner_categories = []
5.times do
  title = Faker::Science.science
  admin_categories << admin_company.categories.create(title: title,
                                                      description: Faker::Lorem.paragraph(sentence_count: 5),
                                                      slug: title.parameterize)

  title = Faker::Space.constellation
  owner_categories << owner_company.categories.create(title: title,
                                                      description: Faker::Lorem.paragraph(sentence_count: 5),
                                                      slug: title.parameterize)
end
puts 'Categories created'

admin_projects = []
owner_projects = []
3.times do
  admin_projects << admin_company.projects.create(name: Faker::Drone.name,
                                                  description: Faker::Lorem.paragraph(sentence_count: 5),
                                                  company_name: Faker::Company.name,
                                                  live_url: Faker::Internet.url,
                                                  repository_url: Faker::Internet.url)

  owner_projects << owner_company.projects.create(name: Faker::Military.army_rank,
                                                  description: Faker::Lorem.paragraph(sentence_count: 5),
                                                  company_name: Faker::Company.name,
                                                  live_url: Faker::Internet.url,
                                                  repository_url: Faker::Internet.url)
end
puts 'Projects created'

4.times do
  title = Faker::Hipster.sentence
  admin_company.posts.create(title: title,
                             content: "#{Faker::HTML.ordered_list}<br /><br />#{Faker::HTML.table}",
                             image_url: Faker::LoremFlickr.image,
                             slug: title.parameterize,
                             short_description: Faker::Lorem.paragraph(sentence_count: 5),
                             credits: "(#{Faker::Internet.url},#{Faker::Company.name},#{Faker::Twitter.screen_name})",
                             category_id: admin_categories.sample.id)

  title = Faker::Hacker.say_something_smart
  owner_company.posts.create(title: title,
                             content: "#{Faker::HTML.ordered_list}<br /><br />#{Faker::HTML.table}",
                             image_url: Faker::LoremFlickr.image,
                             slug: title.parameterize,
                             short_description: Faker::Lorem.paragraph(sentence_count: 5),
                             credits: "(#{Faker::Internet.url},#{Faker::Company.name},#{Faker::Twitter.screen_name})",
                             category_id: owner_categories.sample.id)
end
puts 'Posts created'

admin_profile.educations.create([
                                  {
                                    school_name: Faker::University.name,
                                    career: Faker::Educator.degree,
                                    start_date: '2013-06-01',
                                    end_date: '2018-08-01',
                                    location: "#{Faker::Address.city}, #{Faker::Address.state}",
                                    professional_license: nil,
                                    is_course: false,
                                    relevant_topics: [Faker::Hacker.say_something_smart]
                                  },
                                  {
                                    school_name: Faker::University.name,
                                    career: Faker::Educator.course_name,
                                    start_date: '2018-06-01',
                                    end_date: '2018-12-01',
                                    location: "#{Faker::Address.city}, #{Faker::Address.state}",
                                    professional_license: nil,
                                    is_course: true,
                                    relevant_topics: [Faker::Hacker.say_something_smart, Faker::Hacker.say_something_smart]
                                  }
                                ])

owner_profile.educations.create(school_name: Faker::University.name,
                                career: Faker::Educator.degree,
                                start_date: '2015-08-01',
                                end_date: '2019-10-01',
                                location: "#{Faker::Address.city}, #{Faker::Address.state}",
                                professional_license: nil,
                                is_course: false,
                                relevant_topics: [Faker::Hacker.say_something_smart])
puts 'Educations created'

years_number = 7
admin_jobs = []
owner_jobs = []
3.times do
  admin_jobs << admin_profile.jobs.create(title: Faker::Job.title,
                                          location: "#{Faker::Address.city}, #{Faker::Address.state}",
                                          job_type: rand(1...3),
                                          company_name: Faker::Company.name,
                                          start_date: Faker::Date.between(from: years_number.years.ago, to: (years_number - 1).years.ago),
                                          end_date: Faker::Date.between(from: (years_number - 2).years.ago, to: (years_number - 3).years.ago),
                                          activities: [Faker::Lorem.sentence(word_count: 15), Faker::Lorem.sentence(word_count: 20), Faker::Lorem.sentence(word_count: 17), Faker::Lorem.sentence(word_count: 22)])

  owner_jobs << owner_profile.jobs.create(title: Faker::Job.title,
                                          location: "#{Faker::Address.city}, #{Faker::Address.state}",
                                          job_type: rand(1...3),
                                          company_name: Faker::Company.name,
                                          start_date: Faker::Date.between(from: years_number.years.ago, to: (years_number - 1).years.ago),
                                          end_date: Faker::Date.between(from: (years_number - 2).years.ago, to: (years_number - 3).years.ago),
                                          activities: [Faker::Lorem.sentence(word_count: 15), Faker::Lorem.sentence(word_count: 20), Faker::Lorem.sentence(word_count: 17), Faker::Lorem.sentence(word_count: 22)])
  years_number -= 1
end
puts 'Jobs created'

owner_categories.each do |category|
  Skill.create(name: Faker::Company.buzzword,
               icon_url: Faker::Avatar.image,
               level: rand(1...5),
               category_id: category.id,
               skillable: owner_profile)
end

admin_categories.each do |category|
  rand_number = rand(0..(admin_categories.count - 1))

  Skill.create(name: Faker::Company.buzzword,
               icon_url: Faker::Avatar.image,
               level: rand(1...5),
               category_id: category.id,
               skillable: admin_profile)

  Skill.create(name: Faker::ProgrammingLanguage.name,
               icon_url: Faker::Avatar.image,
               level: rand(1...5),
               category_id: admin_categories[rand_number].id,
               skillable: admin_profile)
end

admin_projects.each do |project|
  rand_number = rand(0..(admin_categories.count - 1))

  Skill.create([{ name: Faker::ProgrammingLanguage.name,
                  icon_url: Faker::Avatar.image,
                  level: rand(1...5),
                  category_id: admin_categories[rand_number].id,
                  skillable: project },
                { name: Faker::Company.buzzword,
                  icon_url: Faker::Avatar.image,
                  level: rand(1...5),
                  category_id: admin_categories[rand_number].id,
                  skillable: project }])
end

owner_projects.each do |project|
  rand_number = rand(0..(owner_categories.count - 1))

  Skill.create([{ name: Faker::ProgrammingLanguage.name,
                  icon_url: Faker::Avatar.image,
                  level: rand(1...5),
                  category_id: owner_categories[rand_number].id,
                  skillable: project },
                { name: Faker::Company.buzzword,
                  icon_url: Faker::Avatar.image,
                  level: rand(1...5),
                  category_id: owner_categories[rand_number].id,
                  skillable: project }])
end

admin_jobs.each do |job|
  rand_number = rand(0..(admin_categories.count - 1))

  Skill.create([{ name: Faker::ProgrammingLanguage.name,
                  icon_url: Faker::Avatar.image,
                  level: rand(1...5),
                  category_id: admin_categories[rand_number].id,
                  skillable: job },
                { name: Faker::Company.buzzword,
                  icon_url: Faker::Avatar.image,
                  level: rand(1...5),
                  category_id: admin_categories[rand_number].id,
                  skillable: job }])
end

owner_jobs.each do |job|
  rand_number = rand(0..(owner_categories.count - 1))

  Skill.create([{ name: Faker::ProgrammingLanguage.name,
                  icon_url: Faker::Avatar.image,
                  level: rand(1...5),
                  category_id: owner_categories[rand_number].id,
                  skillable: job },
                { name: Faker::Company.buzzword,
                  icon_url: Faker::Avatar.image,
                  level: rand(1...5),
                  category_id: owner_categories[rand_number].id,
                  skillable: job }])
end
puts 'Skills created'

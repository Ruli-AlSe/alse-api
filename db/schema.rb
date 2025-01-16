# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2025_01_15_215031) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.string 'slug'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'company_id'
    t.index ['company_id'], name: 'index_categories_on_company_id'
    t.index ['slug'], name: 'index_categories_on_slug', unique: true
  end

  create_table 'companies', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'educations', force: :cascade do |t|
    t.string 'school_name', null: false
    t.string 'career', null: false
    t.date 'start_date'
    t.date 'end_date'
    t.string 'location'
    t.string 'professional_license'
    t.boolean 'is_course', default: false
    t.string 'relevant_topics', default: [], array: true
    t.bigint 'profile_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['profile_id'], name: 'index_educations_on_profile_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'title'
    t.string 'content'
    t.bigint 'company_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.datetime 'deleted_at'
    t.string 'image_url'
    t.string 'credits'
    t.integer 'category_id'
    t.string 'slug'
    t.index ['company_id'], name: 'index_posts_on_company_id'
    t.index ['deleted_at'], name: 'index_posts_on_deleted_at'
  end

  create_table 'profiles', force: :cascade do |t|
    t.string 'name'
    t.string 'last_name'
    t.string 'headliner'
    t.text 'bio'
    t.string 'city'
    t.string 'state'
    t.string 'country'
    t.string 'phone_number'
    t.string 'social_media'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'profilable_type', null: false
    t.bigint 'profilable_id', null: false
    t.index ['profilable_type', 'profilable_id'], name: 'index_profiles_on_profilable'
  end

  create_table 'skills', force: :cascade do |t|
    t.string 'name'
    t.string 'icon_url'
    t.integer 'level'
    t.bigint 'category_id', null: false
    t.bigint 'profile_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['category_id'], name: 'index_skills_on_category_id'
    t.index ['profile_id'], name: 'index_skills_on_profile_id'
  end

  create_table 'tokens', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'token'
    t.datetime 'expires_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_tokens_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.integer 'age'
    t.string 'password_digest'
    t.string 'type'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'company_id', null: false
    t.index ['company_id'], name: 'index_users_on_company_id'
  end

  add_foreign_key 'educations', 'profiles'
  add_foreign_key 'posts', 'companies'
  add_foreign_key 'skills', 'categories'
  add_foreign_key 'skills', 'profiles'
  add_foreign_key 'tokens', 'users'
  add_foreign_key 'users', 'companies'
end

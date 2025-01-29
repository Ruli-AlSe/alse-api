class PolymorphicRelationSkillJobProject < ActiveRecord::Migration[6.1]
  def up
    add_column :skills, :skillable_id, :bigint
    add_column :skills, :skillable_type, :string
    add_index :skills, [:skillable_type, :skillable_id]
    Skill.where.not(profile_id: nil).update_all("skillable_id = profile_id, skillable_type = 'Profile'")
    remove_column :skills, :profile_id
  end

  def down
    add_column :skills, :profile_id, :bigint
    Skill.where(skillable_type: 'Profile').update_all("profile_id = skillable_id")
    remove_index :skills, [:skillable_type, :skillable_id]
    remove_column :skills, :skillable_id
    remove_column :skills, :skillable_type
  end
end

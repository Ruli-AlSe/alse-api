class CreditsType < ActiveRecord::Type::Value
  def cast(value)
    Credits.new(value)
  end

  def serialize(value)
    value.to_s
  end

  def changed_in_place?(raw_old_value, new_value)
    raw_old_value != serialize(new_value)
  end
end

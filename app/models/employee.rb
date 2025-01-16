class Employee < User
  has_one :profile, as: :profilable, dependent: :destroy
end

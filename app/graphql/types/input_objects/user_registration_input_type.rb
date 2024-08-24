module Types
  module InputObjects
    class UserRegistrationInputType < BaseInputObject
      argument :fullname, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
      argument :organization_id, ID, required: true
    end
  end
end
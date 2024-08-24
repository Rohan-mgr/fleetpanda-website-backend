module Types
  module InputObjects
    class AvatarInputType < BaseInputObject
      argument :avatar, String, required: true
      argument :user_id, ID, required:true
    end
  end
end
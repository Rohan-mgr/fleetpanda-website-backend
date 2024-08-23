module Types
  module InputObjects
    class ProfileInputType < BaseInputObject
      argument :address, String, required: false
      argument :gender, Types::Enums::ProfileGenderEnum, required: true
      argument :country, String, required:false
      argument :age, ID, required: false
      argument :contact, String, required: false
      argument :dob, GraphQL::Types::ISO8601DateTime, required: false
      argument :user_id, ID, required: true
    end
  end
end
module Mutations
  module Organizations
    class CreateOrganization < BaseMutation
      argument :name, String, required: true

      field :organization, Types::Organizations::OrganizationType, null: false
      field :errors, [String], null: false

      def resolve(name:)
        org = Organization.new(name: name) 
        if org.save
          {
            organization: org,
            errors: []
          }
        else
          {
            organization: nil, 
            errors: [org.errors.full_messages]
          }
        end
      end
    end
  end
end

module Types
  module Organizations
    class OrganizationResponseType < BaseObject
      field :organizations, [Types::Organizations::OrganizationType], null: true
      field :error, String, null: true
    end
  end
end
module Resolvers
  module Organizations
    class GetOrganizations < BaseResolver
      type Types::Organizations::OrganizationResponseType, null: true

      def resolve
        begin
          orgs = Organization.order('created_at DESC')

          {
            oraganizations: orgs,
            error: nill
          }
        end
      rescue StandardError => err
        {
          organizations: orgs,
          error: err.message
        }
      end
    end
  end
end
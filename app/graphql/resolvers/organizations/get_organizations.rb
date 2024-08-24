module Resolvers
  module Organizations
    class GetOrganizations < BaseResolver
      type Types::Organizations::OrganizationResponseType, null: true

      def resolve
        begin
          orgs = Organization.order('created_at DESC')
          if !orgs.empty?
            {
              organizations: orgs,
              error: nil
            }
          end
        end
      rescue StandardError => err
        {
          organizations: [],
          error: err.message
        }
      end
    end
  end
end
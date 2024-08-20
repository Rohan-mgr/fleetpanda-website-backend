module Resolvers
  module Blogs
    class BlogResolver < BaseResolver
      type [Types::Blogs::BlogType], null: false
      argument :organization_id, ID, as: :org_id, required: true

      def resolve(org_id:)
        org = Organization.find(org_id)
        if org.present?
          org.blogs.order(created_at: :DESC)
        end
      end
    end
  end
end
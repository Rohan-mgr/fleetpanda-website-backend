# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :blogs, description:"Fetch all blogs of specific organization", resolver: Resolvers::Blogs::GetBlogs
    field :blogDetails, description: "Fetch the details of blog", resolver: Resolvers::Blogs::GetBlogDetails
    field :blogComments, description: "Fetch the comments", resolver: Resolvers::Comments::GetComments
    field :session, description: "Resolver for user login", resolver: Resolvers::Users::UserLogin

  end
end

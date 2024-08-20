# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_organization, description: "Mutation for creating organization", mutation: Mutations::Organizations::CreateOrganization
    field :create_blog, description: "Mutation for creating blogs", mutation: Mutations::Blogs::CreateBlog
  end
end

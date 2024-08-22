# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_organization, description: "Mutation for creating organization", mutation: Mutations::Organizations::CreateOrganization
    field :create_blog, description: "Mutation for creating blogs", mutation: Mutations::Blogs::CreateBlog
    field :create_comment, description: "Mutation for creating commentr for both user and blog", mutation: Mutations::Comments::CreateComment
    field :create_user, description: "Mutation for creating user", mutation: Mutations::Users::CreateUser
    field :create_profile, description: "Mutation for creating user profile", mutation: Mutations::Users::CreateProfile
  end
end

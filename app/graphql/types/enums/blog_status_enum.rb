module Types
  module Enums
    class BlogStatusEnum < Types::BaseEnum
      value "published", "The blog is in published state"
      value "hidden", "The blog is in hidden state"
      value "archived", "The blog is in archived state"
    end
  end
end 
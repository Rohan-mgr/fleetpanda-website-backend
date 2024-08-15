class Blog < ApplicationRecord
  enum :status, {
    published: "published", 
    hidden: "hidden", 
    archived: "archived"
  }, default: "published"

  belongs_to :organization
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

end

class Blog < ApplicationRecord
  enum :status, {
    published: "published", 
    hidden: "hidden", 
    archived: "archived"
  }, default: "published"
end

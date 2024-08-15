class Organization < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  #making alias for user class
  # has_many :members, through: :memberships, class_name: "User", source: :user

  has_many :blogs
end

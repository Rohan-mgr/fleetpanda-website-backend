class AddUserRefToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_reference :blogs, :user, null: false, default: 2, foreign_key: true
  end
end

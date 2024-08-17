class RemoveUniqueIndexFromUsersEmail < ActiveRecord::Migration[7.1]
  def change
    remove_index :users, :email if index_exists?(:users, :email)
  end
end

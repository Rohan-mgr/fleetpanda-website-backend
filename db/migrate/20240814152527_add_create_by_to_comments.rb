class AddCreateByToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :created_by, :integer, default: 2, null: false
  end
end

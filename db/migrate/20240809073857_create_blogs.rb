class CreateBlogs < ActiveRecord::Migration[7.1]
  def change
    create_enum :status, ["published",  "hidden", "archived"]
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.enum(:status, enum_type: "status", default: 'published', null: false)
      t.timestamps
    end
  end
end

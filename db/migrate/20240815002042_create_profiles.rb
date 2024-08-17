  class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_enum :gender, ["male",  "female"]
    create_table :profiles do |t|
      t.string :address
      t.string :country
      t.integer :age
      t.string :contact
      t.datetime :dob
      t.enum(:gender, enum_type: "gender")

      t.timestamps
    end
  end
end

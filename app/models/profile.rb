class Profile < ApplicationRecord
  enum :gender, {
    male: "male", 
    female: "female"
  }                              
  
  belongs_to :user
end

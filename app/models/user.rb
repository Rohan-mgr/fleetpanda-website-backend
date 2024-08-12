class User < ApplicationRecord
  #   _validators.delete(:email)
  # _validate_callbacks.each do |callback|
  #   if callback.filter.respond_to?(:attributes) && callback.filter.attributes.include?(:email)
  #     _validate_callbacks.delete(callback)
  #   end
  # end
  # validates :email, presence: true, uniqueness: { scope: :organization }

  has_many :memberships
  has_many :organizations, through: :memberships

  has_many :blogs

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end

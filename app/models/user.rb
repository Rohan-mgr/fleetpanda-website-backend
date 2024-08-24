class User < ApplicationRecord
  include Attachable
  before_save :nullify_avatar_if_absent

  has_many :memberships
  has_many :organizations, through: :memberships

  has_many :comments, as: :commentable

  has_one :profile, dependent: :destroy

  has_one_attached :avatar, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  private

  def nullify_avatar_if_absent
    self.avatar.purge_later unless avatar.attached?
  end

end

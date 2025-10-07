class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[user admin]

  # ASSOCIATIONS
  # ------------
  has_many :api_keys, dependent: :destroy

  # VALIDATIONS
  # ------------
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: ROLES }
end

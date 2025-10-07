class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[user admin]

  # VALIDATIONS
  # ------------
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: ROLES }
  # validates :email, presence: true, uniqueness: true
end

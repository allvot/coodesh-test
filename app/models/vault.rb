class Vault < ApplicationRecord
  # ASSOCIATIONS
  # ------------

  belongs_to :user

  # VALIDATIONS
  # ------------

  validates :name, presence: true
end

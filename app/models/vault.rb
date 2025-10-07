class Vault < ApplicationRecord
  # ASSOCIATIONS
  # ------------

  belongs_to :user
  has_many :documents, dependent: :destroy

  # VALIDATIONS
  # ------------

  validates :name, presence: true
end

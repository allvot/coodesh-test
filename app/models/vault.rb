# frozen_string_literal: true

class Vault < ApplicationRecord
  # ASSOCIATIONS
  # ------------

  belongs_to :user
  has_many :documents, dependent: :destroy
  accepts_nested_attributes_for :documents

  # VALIDATIONS
  # ------------

  validates :name, presence: true
end

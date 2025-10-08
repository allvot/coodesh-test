# frozen_string_literal: true

class Document < ApplicationRecord
  has_one_attached :file

  # ASSOCIATIONS
  # ------------

  belongs_to :vault

  # VALIDATIONS
  # ------------

  validates :name, presence: true
  validates :vault, presence: true
end

# frozen_string_literal: true

class ApiKey < ApplicationRecord
  PERMISSION_LEVELS = %w[read write].freeze
  encrypts :key

  # ASSOCIATIONS
  # ------------

  belongs_to :user

  # VALIDATIONS
  # ------------

  validates :name, presence: true
  validates :permission_level, presence: true, inclusion: { in: PERMISSION_LEVELS }

  # CALLBACKS
  # ---------

  before_save :generate_jwt_key

  private

  def generate_jwt_key
    return unless user_id.present?

    payload = {
      uid: user_id,
      iat: Time.now.to_i,
      jti: SecureRandom.uuid,
      permission_level: permission_level
    }

    secret = ENV['API_KEY_JWT_SECRET'].presence || Rails.application.secret_key_base
    self.key = JWT.encode(payload, secret, 'HS256')
  end

  PERMISSION_LEVELS.each do |level|
    define_method("#{level}?") do
      permission_level == level
    end
  end
end

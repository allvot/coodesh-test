class ApiKey < ApplicationRecord
  encrypts :key

  # ASSOCIATIONS
  # ------------

  belongs_to :user

  # VALIDATIONS
  # ------------

  validates :key, presence: true
  validates :name, presence: true

  # CALLBACKS
  # ---------

  before_validation :generate_jwt_key, on: :create

  private

  def generate_jwt_key
    return if key.present?
    return unless user_id.present?

    payload = {
      id: id,
      uid: user_id,
      iat: Time.now.to_i,
      jti: SecureRandom.uuid
    }

    secret = ENV['API_KEY_JWT_SECRET'].presence || Rails.application.secret_key_base
    self.key = JWT.encode(payload, secret, 'HS256')
  end
end

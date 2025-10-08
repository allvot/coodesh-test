# frozen_string_literal: true

module Api
  class ApiController < ActionController::API
    before_action :authenticate_api_key!

    private

    attr_reader :current_user, :current_level

    def authenticate_api_key!
      authorization = request.headers['Authorization']
      api_key = authorization.gsub('Bearer ', '')

      key_data = JWT.decode(api_key, ENV['API_KEY_JWT_SECRET'].presence || Rails.application.secret_key_base, true,
                            { algorithm: 'HS256' }).first
      @current_user = User.find_by(id: key_data['uid'])
      @current_level = key_data['permission_level']

      return if @current_user.present? && ApiKey::PERMISSION_LEVELS.include?(@current_level)

      render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    def can_read?
      return true if %w[read write].include?(current_level)

      render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    def can_write?
      return true if current_level == 'write'

      render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    def validate_read!
      return if can_read?

      render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    def validate_write!
      return if can_write?

      render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    def serialize(object)
      serializer_class.new(object).serializable_hash
    end

    def serializer_class
      @serializer_class ||= "#{controller_name.singularize.camelize}Serializer".safe_constantize
    end
  end
end

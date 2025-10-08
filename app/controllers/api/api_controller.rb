class Api::ApiController < ActionController::API
  before_action :authenticate_api_key!

  private

  def current_user
    @current_user
  end

  def current_level
    @current_level
  end

  def authenticate_api_key!
    authorization = request.headers['Authorization']
    api_key = authorization.gsub("Bearer ", "")

    key_data = (
      JWT.decode(api_key, ENV['API_KEY_JWT_SECRET'].presence || Rails.application.secret_key_base, true, { algorithm: 'HS256' })
    ).first
    @current_user = User.find_by(id: key_data['uid'])
    @current_level = key_data['permission_level']

    unless @current_user.present? && ApiKey::PERMISSION_LEVELS.include?(@current_level)
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def can_read?
    return true if current_level == 'read' || current_level == 'write'

    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def can_write?
    return true if current_level == 'write'

    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def validate_read!
    return if can_read?

    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def validate_write!
    return if can_write?

    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def serialize(object)
    serializer_class.new(object).serializable_hash
  end

  def serializer_class
    @serializer_class ||= "#{self.controller_name.singularize.camelize}Serializer".constantize
  end
end
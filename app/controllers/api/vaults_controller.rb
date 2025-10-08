class Api::VaultsController < Api::ApiController
  before_action :validate_read!

  def index
    @vaults = Vault.includes(:documents).where(user_id: current_user.id).all
    render json: serialize(@vaults)
  end

  def show
    @vault = Vault.includes(:documents).find(params[:id])
    render json: serialize(@vault)
  end

  # def create
  #   @vault = Vault.new(vault_params)
  #   @vault.user = current_user
  #   @vault.save!
  # end
end

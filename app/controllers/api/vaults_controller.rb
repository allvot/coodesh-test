class Api::VaultsController < Api::ApiController
  def index
    @vaults = Vault.includes(:documents).where(user_id: current_user.id).all
    render json: @vaults, each_serializer: VaultSerializer
  end

  def show
    @vault = Vault.includes(:documents).find(params[:id])
    render json: @vault, serializer: VaultSerializer
  end

  def create
    @vault = Vault.new(vault_params)
    @vault.user = current_user
    @vault.save!
  end
end

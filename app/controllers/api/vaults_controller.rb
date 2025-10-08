class Api::VaultsController < Api::ApiController
  def index
    @vaults = Vault.where(user_id: current_user.id).all
  end

  def show
    @vault = Vault.find(params[:id])
  end

  def create
    @vault = Vault.new(vault_params)
    @vault.user = current_user
    @vault.save!
  end
end

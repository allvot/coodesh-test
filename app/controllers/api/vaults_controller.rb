# frozen_string_literal: true

module Api
  class VaultsController < Api::ApiController
    before_action :validate_read!
    before_action :validate_write!, only: %i[create]

    def index
      @vaults = Vault.includes(:documents).where(user_id: current_user.id).all
      render json: serialize(@vaults)
    end

    def show
      @vault = Vault.includes(:documents).find(params[:id])
      render json: serialize(@vault)
    end

    def create
      @vault = Vault.new(vault_params)
      @vault.user = current_user

      if @vault.save!
        render json: serialize(@vault)
      else
        render json: { errors: @vault.errors }, status: :unprocessable_entity
      end
    end

    def vault_params
      params.require(:vault).permit(:name, documents_attributes: %i[name file _destroy])
    end
  end
end

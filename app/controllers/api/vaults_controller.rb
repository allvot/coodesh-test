# frozen_string_literal: true

module Api
  class VaultsController < Api::ApiController
    before_action :validate_read!
    before_action :validate_write!, only: %i[create update destroy]
    before_action :set_vault, only: %i[show update destroy]

    def index
      @vaults = user_vaults.all
      render json: serialize(@vaults)
    end

    def show
      render json: serialize(@vault)
    end

    def create
      @vault = Vault.new(vault_params)
      @vault.user = current_user

      if @vault.save
        render json: serialize(@vault)
      else
        render json: { errors: @vault.errors }, status: :unprocessable_entity
      end
    end

    def update
      @vault.user = current_user

      if @vault.update(vault_params)
        render json: serialize(@vault)
      else
        render json: { errors: @vault.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @vault.destroy!
      head :no_content
    end

    private

    def user_vaults
      Vault.includes(:documents).where(user_id: current_user.id)
    end

    def set_vault
      @vault = user_vaults.find(params[:id])

      return if @vault.present?

      render json: { errors: ['Vault not found'] }, status: :not_found
    end

    def vault_params
      params.require(:vault).permit(:name, documents_attributes: %i[name file _destroy])
    end
  end
end

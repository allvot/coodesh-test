class Api::DocumentsController < Api::ApiController
  before_action :set_vault
  before_action :authenticate_api_key!
  before_action :validate_read!
  before_action :set_document, only: %i[show update destroy]

  def index
    @documents = Document.where(vault_id: params[:vault_id])
    render json: serialize(@documents)
  end

  def show
    render json: serialize(@document)
  end

  def download
    send_data @document.file.download, filename: @document.name, type: @document.file.content_type
  end

  def update
    @document.update!(document_params)
    render json: serialize(@document)
  end

  def destroy
    @document.destroy!
    head :no_content
  end

  private

  def vault_documents
    @vault.documents
  end

  def set_vault
    @vault = Vault.find(params[:vault_id])
  end

  def set_document
    @document = vault_documents.find(params[:id])

    return if @document.present?

    render json: { error: 'Document not found' }, status: :not_found
  end

  def document_params
    params.expect(document: %i[name file])
  end
end

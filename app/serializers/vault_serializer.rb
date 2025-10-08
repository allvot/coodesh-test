# frozen_string_literal: true

class VaultSerializer
  include JSONAPI::Serializer
  attributes :id, :name
  has_many :documents, serializer: DocumentSerializer
end

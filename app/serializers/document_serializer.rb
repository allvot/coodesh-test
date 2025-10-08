# frozen_string_literal: true

class DocumentSerializer
  include JSONAPI::Serializer
  attributes :id, :name
end

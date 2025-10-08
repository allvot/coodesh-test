class DocumentSerializer
  include JSONAPI::Serializer
  attributes :id, :name
end

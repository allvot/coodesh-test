# frozen_string_literal: true

module RequestsSupport
  extend ActiveSupport::Concern

  included do
    def json_body
      JSON.parse(response.body)
    end

    def json_data
      json_body['data']
    end

    def json_errors
      json_body['errors']
    end

    RSpec::Matchers.define :match_json_response do |expected|
      match do |actual|
        if actual.is_a?(Array)
          actual.each do |item|
            expect(item).to match_json_response(expected)
          end
        else
          begin
            serializer_class = "#{expected.class.name}Serializer".safe_constantize
            serialized_expected = serializer_class.new(expected).serializable_hash.deep_stringify_keys
            expect(actual.to_json).to eq(serialized_expected['data'].to_json)
          rescue NoMethodError
            raise "Serializer not found for #{expected.class.name}"
          end
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include RequestsSupport, type: :request
end

module Sendowl
  class License
    attr_reader :id, :order_id, :product_id, :key, :order_refunded

    def initialize(product_id:, key:, id: nil, order_id: nil, order_refunded: nil)
      @id = id
      @order_id = order_id
      @product_id = product_id
      @key = key
      @order_refunded = order_refunded
    end

    def valid?
      license = Sendowl::Request.new(
        check_valid_path,
        "GET",
        self.class,
        { query: { key: key } }
      ).call.first

      !(license.nil? || license.order_id.nil? || license.order_refunded)
    end

    class << self
      def parse(response)
        case response
        when Array
          response.map { |x| parse x }
        when Hash
          if response["licenses"]
            response["licenses"]["invalid_keys"]
          else
            new response["license"].transform_keys { |k| k.to_sym }
          end
        else
          response
        end
      end
    end

    private

    def check_valid_path
      "/products/#{product_id}/licenses/check_valid"
    end
  end
end

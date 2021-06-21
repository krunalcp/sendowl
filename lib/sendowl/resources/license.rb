module Sendowl
  class License
    attr_reader :id, :order_id, :product_id, :key, :order_refunded, :status

    def initialize(product_id:, key:, id: nil, order_id: nil, order_refunded: nil, status: nil)
      @id = id
      @order_id = order_id
      @product_id = product_id
      @key = key
      @order_refunded = order_refunded
      @status = status
    end

    def valid?
      license_res = Sendowl::Request.new(
        check_valid_path,
        'GET',
        self.class,
        { query: { key: key } }
      ).run.first
      if license_res&.dig('license', 'order_id').present?
        status = find_order_status(license_res.dig('license', 'order_id'))
        license_res['license'].merge!(status: status)
      end
      License.parse(license_res)
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

    def find_order_status(order_id)
      order = Sendowl::Request.new("/orders/#{order_id}.json", 'Get', 'Order').run
      order.present? ? order['order']['state'].to_s.downcase : nil
    end

    def check_valid_path
      "/products/#{product_id}/licenses/check_valid"
    end
  end
end

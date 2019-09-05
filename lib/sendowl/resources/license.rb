module Sendowl
  class License
    attr_reader :key, :product_id

    def initialize(product_id:, key:)
      @product_id = product_id
      @key = key
    end

    def valid?
      licenses = Sendowl::Request.new(
        check_valid_path,
        "GET",
        { query: { key: key } }
      ).run

      !(licenses.empty? || licenses.first["license"]["order_refunded"])
    end

    private

    def check_valid_path
      "/products/#{product_id}/licenses/check_valid"
    end
  end
end

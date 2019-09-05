require "uri"
require "rest_client"
require "json"

module Sendowl
  class Request
    attr_accessor :path, :method, :parameters, :headers, :query

    DEFAULT_HEADERS = {
      'Content-Type' => 'application/json; charset=utf8',
      'Accept'       => 'application/json',
      'User-Agent'   => "sendowl-ruby/#{Sendowl::VERSION}"
    }

    def initialize(path, method, options={})
      @path       = path
      @method     = method
      @parameters = options[:params]  || {}
      @query      = options[:query]   || {}
      @headers    = options[:headers] || {}
    end

    def run
      response = RestClient::Request.execute request_params
      JSON.parse response.body
    end

    protected

    def request_params
      {
        method:       method,
        user:         Sendowl.api_key,
        password:     Sendowl.api_secret,
        url:          api_url,
        payload:      JSON.generate(parameters),
        open_timeout: Sendowl.open_timeout,
        timeout:      Sendowl.timeout,
        headers:      DEFAULT_HEADERS.merge(headers),
        ssl_version:  'TLSv1_2'
      }
    end

    def api_url
      url = Sendowl.api_endpoint + path
      url += '?' + URI.encode_www_form(query) unless query.empty?

      url
    end
  end
end

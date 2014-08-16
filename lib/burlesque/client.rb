require 'net/http'
require 'json'

module Burlesque
  class Client
    attr_reader :http

    PUB_ENDPOINT = '/publish'
    SUB_ENDPOINT = '/subscribe'
    STATUS_ENDPOINT = '/status'
    DEBUG_ENDPOINT = '/debug'
    OK = 'OK'

    def initialize
      @http = Net::HTTP.new(Burlesque.config.host, Burlesque.config.port)
      @http.read_timeout = Burlesque.config.timeout
    end

    def publish queue, message
      req = Net::HTTP::Post.new("#{PUB_ENDPOINT}?queue=#{queue}")
      req.body = message
      res = http.request(req)
      res.body == OK
    end

    def subscribe *queues
      req = Net::HTTP::Get.new("#{SUB_ENDPOINT}?queues=#{queues.join(?,)}")

      begin
        res = http.request(req)
        {message: res.body, queue: res.header['Queue']} if res.is_a? Net::HTTPOK
      rescue Net::ReadTimeout
      end
    end

    def status
      req = Net::HTTP::Get.new(STATUS_ENDPOINT)
      res = http.request(req)
      JSON.parse(res.body) if res.is_a? Net::HTTPOK
    end

    def debug
      req = Net::HTTP::Get.new(DEBUG_ENDPOINT)
      res = http.request(req)
      JSON.parse(res.body) if res.is_a? Net::HTTPOK
    end
  end
end

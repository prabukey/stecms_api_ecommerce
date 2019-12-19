require "rest-client"

module StecmsApiEcommerce
  module Service
    class Ecommerce

      def self.call(url, page=1)
        url = ENV["STORE_URL_API"]  + url + "?token=#{ENV["STORE_KEY"]}&page=#{page}"
        RestClient.get url,  {accept: :json} { |res|
          case res.code
          when 200
            JSON.parse res.body
          when 404
            raise "TODO"
          when 500
            raise "TODO"
          end
        }
      end

    end
  end
end

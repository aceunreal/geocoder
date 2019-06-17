require "geocoder/lookups/google"
require "geocoder/results/google_places_search"

module Geocoder
  module Lookup
    class GooglePlacesSearch < Google
      def name
        "Google Places Search"
      end

      def required_api_key_parts
        ["key"]
      end

      def supported_protocols
        [:https]
      end

      def query_url(query)
        "#{protocol}://maps.googleapis.com/maps/api/place/textsearch/json?#{url_query_string(query)}"
      end

      private

      def results(query)
        return [] unless doc = fetch_data(query)
        case doc["status"]
        when "OK"
          return doc["results"]
        when "OVER_QUERY_LIMIT"
          raise_error(Geocoder::OverQueryLimitError) ||
            Geocoder.log(:warn, "#{name} API error: over query limit.")
        when "REQUEST_DENIED"
          raise_error(Geocoder::RequestDenied) ||
            Geocoder.log(:warn, "#{name} API error: request denied.")
        when "INVALID_REQUEST"
          raise_error(Geocoder::InvalidRequest) ||
            Geocoder.log(:warn, "#{name} API error: invalid request.")
        end

        []

      def base_query_url(query)
        "#{protocol}://maps.googleapis.com/maps/api/place/textsearch/json?"
      end

      def query_url_google_params(query)
        {
          query: query.text,
          language: query.language || configuration.language
        }
      end
    end
  end
end

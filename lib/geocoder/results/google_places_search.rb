<<<<<<< 510afa855089b8fe448f30e1ab209315e0bae653
require 'geocoder/results/google'
=======
require "geocoder/results/google"
>>>>>>> Google Places Search Lookup (#1143)

module Geocoder
  module Result
    class GooglePlacesSearch < Google

      def types
        @data["types"] || []
      end

      def rating
        @data["rating"]
      end

      def photos
        @data["photos"]
      end

      def city
        ""
      end

      def state
        ""
      end

      def state_code
        ""
      end

      def province
        ""
      end

      def province_code
        ""
      end

      def postal_code
        ""
      end

      def country
        ""
      end

      def country_code
        ""
      end
    end
  end
end

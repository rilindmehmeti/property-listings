module Mw
  module Listing
    class GroupedListingPriceForDates < PriceForDates
      def seasonal_rates
        @seasonal_rates ||= set_rates
      end

      def formatted_seasonal_rates
        @formatted_seasonal_rates ||= set_rates
      end

      private

      def set_rates
        result = []
        total_rates = start_dates.length
        total_rates.times do |i|
          result << [start_dates[i], end_dates[i], rates[i]]
        end
        result
      end

      def start_dates
        @seasonal_starts ||= listing.seasonal_starts.compact
      end

      def end_dates
        @seasonal_ends ||= listing.seasonal_ends.compact
      end

      def rates
        @rates ||= listing.rates.compact
      end
    end
  end
end

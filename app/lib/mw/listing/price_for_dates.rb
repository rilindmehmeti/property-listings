module Mw
  module Listing
    class PriceForDates
      attr_reader :listing, :start_date, :end_date

      delegate :default_daily_rate, :seasonal_rates, to: :listing

      def initialize(listing, start_date, end_date)
        @listing = listing
        @start_date = start_date
        @end_date = end_date
      end

      def call
        return default_price_calculation unless seasonal_rates.any?
        mixed_price_calculation
      end

      private

      def search_days
        (end_date - start_date).to_i
      end

      def default_price_calculation
        search_days * default_daily_rate
      end

      def mixed_price_calculation
        total_price = 0
        total_days = search_days
        seasonal_rates.pluck(:start_date, :end_date, :daily_rate).map do |price|
          _start_date, _end_date, daily_rate = price
          days = FindSeasonalDaysIntersection.new(start_date, end_date, _start_date, _end_date).call
          total_days -= days
          total_price += (days * daily_rate)
        end
        total_price += (total_days * default_daily_rate)
        total_price
      end
    end
  end
end

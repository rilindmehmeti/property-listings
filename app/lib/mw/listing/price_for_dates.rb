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

      def search_dates_range
        @search_dates_range ||= get_search_dates_range
      end

      def get_search_dates_range
        range = (start_date..end_date).to_a
        range.pop
        range
      end

      def default_price_calculation
        (end_date - start_date).to_i * default_daily_rate
      end

      def mixed_price_calculation
        total_price = 0
        total_days = search_dates_range.length
        mapped_prices.each do |key, value|
          common_days = (value & search_dates_range).length
          next if common_days.zero?
          total_days -= common_days
          total_price += (common_days * key)
        end
        total_price += (total_days * default_daily_rate)
        total_price
      end

      def mapped_prices
        @mapped_prices ||= map_prices
      end

      def map_prices
        mapping = {}
        seasonal_rates.pluck(:start_date, :end_date, :daily_rate).map do |price|
          start_date, end_date, daily_rate = price
          dates = (start_date..end_date).to_a
          dates.pop
          mapping[daily_rate] = dates
        end
        mapping
      end
    end
  end
end

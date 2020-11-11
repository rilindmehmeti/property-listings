module Mw
  module Listing
    class FindSeasonalDaysIntersection
      attr_reader :search_start_date, :search_end_date, :seasonal_start_date, :seasonal_end_date

      def initialize(search_start_date, search_end_date, seasonal_start_date, seasonal_end_date)
        @search_start_date = search_start_date
        @search_end_date = search_end_date
        @seasonal_start_date = seasonal_start_date
        @seasonal_end_date = seasonal_end_date
      end

      def call
        days = 0
        # when there is no intersection with seasonal date range
        return days if invalid? || seasonal_start_date >= search_end_date || search_start_date > seasonal_end_date
        if seasonal_end_date > search_end_date && search_start_date <= seasonal_start_date
          # When search date is outside the seasonal date range, but search end date is inside it
          days = (search_end_date - seasonal_start_date).to_i
        elsif seasonal_end_date >= search_end_date && search_start_date >= seasonal_start_date
          # When both start search date and end search date are inside the seasonal date range
          days = (search_end_date - search_start_date).to_i
        elsif seasonal_end_date < search_end_date && search_start_date >= seasonal_start_date
          # When start search date is inside the seasonal date range and end search date is outside it
          days = (seasonal_end_date - search_start_date).to_i + 1
        elsif seasonal_end_date < search_end_date && search_start_date < seasonal_start_date
          # When seasonal date range and end search date is outside it
          days = (seasonal_end_date - seasonal_start_date).to_i + 1
        end
        days
      end

      def invalid?
        return true if search_start_date.nil? || search_end_date.nil? || seasonal_start_date.nil? || seasonal_end_date.nil?
        return true if search_end_date < search_start_date || seasonal_end_date < seasonal_start_date
        false
      end
    end
  end
end

class Listing < ApplicationRecord
  has_many :seasonal_rates

  scope :with_seasonal_rates, -> { left_outer_joins(:seasonal_rates)
                                       .select("listings.id, title, default_daily_rate, array_agg(seasonal_rates.start_date) as seasonal_starts, array_agg(seasonal_rates.end_date) as seasonal_ends, array_agg(seasonal_rates.daily_rate) as rates")
                                       .group("listings.id")
  }
end

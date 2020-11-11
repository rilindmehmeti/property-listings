class ListingsController < ApplicationController
  def index
    #@start_date, @end_date = Date.parse("30-06-2020"), Date.parse("09-07-2020")
    @start_date, @end_date = Date.parse("30-06-2021"), Date.parse("09-07-2021")
    #@listings = ListingDecorator.decorate_collection(Listing.all, context: { start_date: @start_date, end_date: @end_date })
    #@listings = ListingDecorator.decorate_collection(Listing.all.includes(:seasonal_rates), context: { start_date: @start_date, end_date: @end_date })
    @listings = GroupedListingDecorator.decorate_collection(Listing.with_seasonal_rates, context: { start_date: @start_date, end_date: @end_date })
  end
end

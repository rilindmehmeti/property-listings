describe Mw::Listing::PriceForDates do
  let(:default_price)  { 100 }
  let(:seasonal_price) { 150 }
  let(:start_date)     { Date.parse("01-05-2021") }
  let(:end_date)       { Date.parse("10-05-2021") }
  let(:listing)        { FactoryBot.create(:listing, default_daily_rate: default_price) }

  subject { described_class.new(listing, start_date, end_date) }

  describe ".call" do
    let(:result)          { subject.call }

    it "calculates price based on default price" do
      expect(result).to eq(9 * default_price)
    end

    context "when listing has seasonal rate" do
      let(:seasonal_start_date) { Date.parse("01-07-2021") }
      let(:seasonal_end_date)   { Date.parse("01-09-2021") }

      let!(:seasonal_rate)      { FactoryBot.create(:seasonal_rate, listing: listing, start_date: seasonal_start_date, end_date: seasonal_end_date, daily_rate: seasonal_price) }

      it "calculate price based on default price when search dates are outside the seasonal rate" do
        expect(result).to eq(9 * default_price)
      end

      context "when dates of search are inside the seasonal rate" do
        let(:start_date)     { Date.parse("01-08-2021") }
        let(:end_date)       { Date.parse("10-08-2021") }

        it "calculates price based on seasonal price" do
          expect(result).to eq(9 * seasonal_price)
        end
      end

      context "when start date of seasonal rate is included in the dates" do
        let(:start_date)     { Date.parse("30-06-2021") }
        let(:end_date)       { Date.parse("09-07-2021") }

        it "calculates price for dates outside the seasonal rate, and for those inside" do
          expect(result).to eq((1 * default_price) + ( 8 * seasonal_price ))
        end
      end

      context "when start date of seasonal rate is included in the dates" do
        let(:start_date)     { Date.parse("25-08-2021") }
        let(:end_date)       { Date.parse("03-09-2021") }

        it "calculates price for dates outside the seasonal rate, and for those inside" do
          expect(result).to eq((1 * default_price) + ( 8 * seasonal_price ))
        end
      end

      context "when dates include the whole seasonal rate" do
        let(:seasonal_start_date) { Date.parse("01-07-2021") }
        let(:seasonal_end_date)   { Date.parse("10-07-2021") }
        let(:start_date)          { Date.parse("30-06-2021") }
        let(:end_date)            { Date.parse("12-07-2021") }

        it "calculates the price correctly for combined seasonal rate and default rate" do
          expect(result).to eq((2 * default_price) + ( 10 * seasonal_price ))
        end
      end
    end
  end
end

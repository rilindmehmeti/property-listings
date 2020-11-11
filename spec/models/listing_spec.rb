describe Listing, type: :model do
  describe "scopes" do
    describe "with_seasonal_rates" do
      let(:title)              { "Amazing Listing" }
      let(:default_daily_rate) { 10 }
      let!(:listing)            { FactoryBot.create(:listing, title: title, default_daily_rate: default_daily_rate) }

      subject { described_class.with_seasonal_rates.first }

      it "returns title and default daily rate, empty seasonal starts, seasonal ends and rates" do
        expect(subject.id).to                      eq(listing.id)
        expect(subject.title).to                   eq(title)
        expect(subject.default_daily_rate).to      eq(default_daily_rate)
        expect(subject.seasonal_starts.compact).to be_empty
        expect(subject.seasonal_ends.compact).to   be_empty
        expect(subject.rates.compact).to           be_empty
      end

      context "when there are seasonal rates for listing" do
        let(:start_date)     { Date.parse("29-07-1995") }
        let(:end_date)       { Date.parse("31-07-1995") }
        let(:rate)           { 100 }
        let!(:seasonal_rate) { FactoryBot.create(:seasonal_rate, listing: listing, start_date: start_date, end_date: end_date, daily_rate: rate) }

        it "returns seasonal rates" do
          expect(subject.seasonal_starts).to eq([start_date])
          expect(subject.seasonal_ends).to   eq([end_date])
          expect(subject.rates).to           eq([rate])
        end

        context "with multiple seasonal rates" do
          let(:second_start_date)     { Date.parse("29-07-1996") }
          let(:second_end_date)       { Date.parse("31-07-1996") }
          let(:second_rate)           { 150 }
          let!(:second_seasonal_rate) { FactoryBot.create(:seasonal_rate, listing: listing, start_date: second_start_date, end_date: second_end_date, daily_rate: second_rate) }

          it "returns seasonal rates in the right order" do
            expect(subject.seasonal_starts).to eq([second_start_date, start_date])
            expect(subject.seasonal_ends).to   eq([second_end_date, end_date])
            expect(subject.rates).to           eq([second_rate, rate])
          end
        end
      end
    end
  end
end

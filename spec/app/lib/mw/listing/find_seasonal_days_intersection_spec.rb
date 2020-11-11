describe Mw::Listing::FindSeasonalDaysIntersection do
  let(:search_start_date)   { Date.parse("01-05-2021") }
  let(:search_end_date)     { Date.parse("10-05-2021") }
  let(:seasonal_start_date) { Date.parse("01-06-2021") }
  let(:seasonal_end_date)   { Date.parse("10-06-2021") }

  subject { described_class.new(search_start_date, search_end_date, seasonal_start_date, seasonal_end_date).call }

  describe ".call" do
    it "returns 0 when end search date is earlier than seasonal start date" do
      expect(subject).to eq(0)
    end

    context "when start date is greater than seasonal end date" do
      let(:search_start_date) { Date.parse("11-06-2021") }
      let(:search_end_date)   { Date.parse("21-06-2021") }

      it "returns 0" do
        expect(subject).to eq(0)
      end
    end

    context "when search start date is outside the seasonal date range, but search end date is inside" do
      let(:search_start_date) { Date.parse("25-05-2021") }
      let(:search_end_date)   { Date.parse("05-06-2021") }

      it "returns 4" do
        expect(subject).to eq(4)
      end
    end

    context "when search date is inside the seasonal date range, but search end date is outside" do
      let(:search_start_date) { Date.parse("05-06-2021") }
      let(:search_end_date)   { Date.parse("15-06-2021") }

      it "returns 6" do
        expect(subject).to eq(6)
      end
    end

    context "when both search start and end date are inside the seasonal range" do
      let(:search_start_date) { Date.parse("01-06-2021") }
      let(:search_end_date)   { Date.parse("10-06-2021") }

      it "returns 9" do
        expect(subject).to eq(9)
      end
    end

    context "when seasonal range is inside search start date and end date" do
      let(:search_start_date) { Date.parse("25-05-2021") }
      let(:search_end_date)   { Date.parse("15-06-2021") }

      it "returns 10" do
        expect(subject).to eq(10)
      end
    end
  end
end

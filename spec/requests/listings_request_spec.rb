describe "Listings", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/listings"
      expect(response).to have_http_status(:success)
    end
  end

end

require "rails_helper"

RSpec.describe "Raters", type: :routing do
  describe "route" do
    it "to #inbox" do
      expect(post("/rate")).to route_to("rater#create")
    end
  end
end
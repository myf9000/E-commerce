require "rails_helper"

RSpec.describe "Comments", type: :routing do
  describe "CRUD's route" do
    it "to #create" do
      expect(post("/comments")).to route_to("comments#create")
    end
  end
end
require "rails_helper"

RSpec.describe "Users", type: :routing do
  describe "CRUD's route" do
    it "to #show" do
      expect(get("/users/1")).to route_to("users#show", :id => "1")
    end
  end

  describe "members route" do
	  it "to #follow" do
	  	expect(get("/users/1/follow")).to route_to("users#follow", :id => "1")
	  end
	end
end
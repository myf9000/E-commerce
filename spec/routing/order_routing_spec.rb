require "rails_helper"

RSpec.describe "Orders", type: :routing do
  describe "CRUD's route" do
    it "to #index" do
      expect(get("/orders")).to route_to("orders#index")
    end

    it "to #new" do
      expect(get("/orders/new")).to route_to("orders#new")
    end

    it "to #show" do
      expect(get("/orders/1")).to route_to("orders#show", :id => "1")
    end

    it "to #edit" do
      expect(get("/orders/1/edit")).to route_to("orders#edit", :id => "1")
    end

    it "to #create" do
      expect(post("/orders")).to route_to("orders#create")
    end

    it "to #update" do
      expect(put("/orders/1")).to route_to("orders#update", :id => "1")
    end

    it "to #destroy" do
      expect(delete("/orders/1")).to route_to("orders#destroy", :id => "1")
    end
  end
end
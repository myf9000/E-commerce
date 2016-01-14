require "rails_helper"

RSpec.describe "OrderItems", type: :routing do
  describe "CRUD's route" do
    it "to #index" do
      expect(get("/order_items")).to route_to("order_items#index")
    end

    it "to #new" do
      expect(get("/order_items/new")).to route_to("order_items#new")
    end

    it "to #show" do
      expect(get("/order_items/1")).to route_to("order_items#show", :id => "1")
    end

    it "to #edit" do
      expect(get("/order_items/1/edit")).to route_to("order_items#edit", :id => "1")
    end

    it "to #create" do
      expect(post("/order_items")).to route_to("order_items#create")
    end

    it "to #update" do
      expect(put("/order_items/1")).to route_to("order_items#update", :id => "1")
    end

    it "to #destroy" do
      expect(delete("/order_items/1")).to route_to("order_items#destroy", :id => "1")
    end
  end

  describe "collections route" do
    it "to #delivered" do
      expect(get("/order_items/delivered")).to route_to("order_items#delivered")
    end

    it "to #buy" do
      expect(get("/order_items/buy")).to route_to("order_items#buy")
    end
  end

  describe "members route" do
    it "to #product_orders" do
      expect(get("/order_items/1/product_orders")).to route_to("order_items#product_orders", :id => "1")
    end
  end
end
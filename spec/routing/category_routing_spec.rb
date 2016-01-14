require "rails_helper"

RSpec.describe "Categories", type: :routing do
  describe "CRUD's route" do
    it "to #index" do
      expect(get("/categories")).to route_to("categories#index")
    end

    it "to #new" do
      expect(get("/categories/new")).to route_to("categories#new")
    end

    it "to #show" do
      expect(get("/categories/1")).to route_to("categories#show", :id => "1")
    end

    it "to #edit" do
      expect(get("/categories/1/edit")).to route_to("categories#edit", :id => "1")
    end

    it "to #create" do
      expect(post("/categories")).to route_to("categories#create")
    end

    it "to #update" do
      expect(put("/categories/1")).to route_to("categories#update", :id => "1")
    end

    it "to #destroy" do
      expect(delete("/categories/1")).to route_to("categories#destroy", :id => "1")
    end
  end
end
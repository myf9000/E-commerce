require "rails_helper"

RSpec.describe "Products", type: :routing do
  describe "CRUD's route" do
    it "to #index" do
      expect(get("/products")).to route_to("products#index")
    end

    it "to #new" do
      expect(get("/products/new")).to route_to("products#new")
    end

    it "to #show" do
      expect(get("/products/1")).to route_to("products#show", :id => "1")
    end

    it "to #edit" do
      expect(get("/products/1/edit")).to route_to("products#edit", :id => "1")
    end

    it "to #create" do
      expect(post("/products")).to route_to("products#create")
    end

    it "to #update" do
      expect(put("/products/1")).to route_to("products#update", :id => "1")
    end

    it "to #destroy" do
      expect(delete("/products/1")).to route_to("products#destroy", :id => "1")
    end
  end

  describe "others route" do
    it "to root_path" do
      expect(get("/")).to route_to("products#index") 
    end

    it "to searching" do
      expect(get("/searching")).to route_to("products#searching") 
    end

    it "to sort" do
      expect(get("/sort/sort")).to route_to("products#sort_list", :sort => "sort") 
    end
  end
end
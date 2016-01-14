require "rails_helper"

RSpec.describe "Conversations", type: :routing do
  describe "CRUD's route" do
    it "to #index" do
      expect(get("/conversations")).to route_to("conversations#index")
    end

    it "to #new" do
      expect(get("/conversations/new")).to route_to("conversations#new")
    end

    it "to #show" do
      expect(get("/conversations/1")).to route_to("conversations#show", :id => "1")
    end

    it "to #edit" do
      expect(get("/conversations/1/edit")).to route_to("conversations#edit", :id => "1")
    end

    it "to #create" do
      expect(post("/conversations")).to route_to("conversations#create")
    end

    it "to #update" do
      expect(put("/conversations/1")).to route_to("conversations#update", :id => "1")
    end

    it "to #destroy" do
      expect(delete("/conversations/1")).to route_to("conversations#destroy", :id => "1")
    end
  end

  describe "members route" do
    it "to #reply" do
      expect(post("conversations/1/reply")).to route_to("conversations#reply", :id => "1")
    end

    it "to #trash" do
      expect(post("conversations/1/trash")).to route_to("conversations#trash", :id => "1")
    end

    it "to #untrash" do
      expect(post("conversations/1/untrash")).to route_to("conversations#untrash", :id => "1")
    end
  end
end
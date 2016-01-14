require "rails_helper"

RSpec.describe "Infos", type: :routing do
  describe "CRUD's route" do
    it "to #new" do
      expect(get("/infos/new")).to route_to("infos#new")
    end

    it "to #show" do
      expect(get("/infos/1")).to route_to("infos#show", :id => "1")
    end

    it "to #edit" do
      expect(get("/infos/1/edit")).to route_to("infos#edit", :id => "1")
    end

    it "to #create" do
      expect(post("/infos")).to route_to("infos#create")
    end

    it "to #update" do
      expect(put("/infos/1")).to route_to("infos#update", :id => "1")
    end

    it "to #destroy" do
      expect(delete("/infos/1")).to route_to("infos#destroy", :id => "1")
    end
  end
end
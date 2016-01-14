require "rails_helper"

describe ApplicationHelper do
  describe "helper methods" do
	  context "#check_stock true" do
	    it { expect(helper.check_stock(1)).to eq(true) }
	  end

	  context "#check_stock false" do
	    it { expect(helper.check_stock(0)).to eq(false) }
	  end

	  context "#flash_class notice" do
	    it { expect(helper.flash_class("notice")).to eq("alert alert-success") }
	  end

	  context "#flash_class info" do
	    it { expect(helper.flash_class("info")).to eq("alert alert-info") }
	  end

	  context "#flash_class alert" do
	    it { expect(helper.flash_class("alert")).to eq("alert alert-danger") }
	  end

	  context "#flash_class warning" do
	    it { expect(helper.flash_class("warning")).to eq("alert alert-warning") }
	  end

	  context "#set_title_of_page Index" do
	    it { expect(helper.set_title_of_page("Index")).to eq("Index | Shopper") }
	  end

	  context "#set_title_of_page nil" do
	    it { expect(helper.set_title_of_page).to eq("Shopper") }
	  end
	end
end
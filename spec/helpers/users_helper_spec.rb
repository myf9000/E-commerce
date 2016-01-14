require "rails_helper"

describe UsersHelper do
  describe "helper methods" do
	  context "#print_user_score" do
	    it { expect(helper.print_user_score(1.499991)).to eq(1.50) }
	  end
	end
end
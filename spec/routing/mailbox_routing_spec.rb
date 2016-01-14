require "rails_helper"

RSpec.describe "Mailboxes", type: :routing do
  describe "route" do
    it "to #inbox" do
      expect(get("/mailbox/inbox")).to route_to("mailbox#inbox")
    end

    it "to #sent" do
      expect(get("/mailbox/sent")).to route_to("mailbox#sent")
    end

    it "to #trash" do
      expect(get("/mailbox/trash")).to route_to("mailbox#trash")
    end
  end
end
require 'rails_helper'

RSpec.describe Picture, type: :model do
	
	describe "validations" do
	  it { should have_attached_file(:pict) }
	  it { should validate_attachment_content_type(:pict).allowing('image/png', 'image/gif').rejecting('text/plain', 'text/xml') }
	end

	describe "associations" do
  	it { should belong_to(:product) }
	end
end
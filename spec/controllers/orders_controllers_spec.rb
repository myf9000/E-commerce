require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
	context "User not logged in " do 
    describe "GET #new_user_session" do
      it "redirects to login page" do 
        get :show, id: 1
        expect(response).to redirect_to new_user_session_path
      end 
    end
  end

	context "User logged in" do 
    let(:user) { create(:user) }
	  let(:order) { create(:order, user: user) }

	  before { sign_in(user) }

	  describe "GET #show" do
	    it "assigns @order" do
	      get :show, id: order
	      expect(assigns(:order)).to eq(order)
	    end

	    it "renders the :show view" do
	      get :show, id: order
	      expect(response).to render_template :show
	    end
	  end

	  describe "DELETE #destroy" do 
	  	it "deletes order" do
	  		order_one = create(:order, user: user)
	  	  expect{delete :destroy, id: order_one}.to change(Order,:count).by(-1)
	  	end

	  	it "redirect to root path" do
	  	  get :destroy, id: order
	  	  expect(response).to redirect_to products_path
	  	end
	  end
	end
end
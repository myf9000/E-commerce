require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "User not logged in " do 
    describe "GET #new_session" do
      it "redirects to login page" do 
        get :show, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end 
    end
  end

  context "User logged in" do 
	  let(:user) { create(:user) }
	  let(:user2) { create(:user) }
	  let(:comment) { create(:comment, user: user) }
	  let(:product) { create(:product, user: user) }
	  
	  before { sign_in(user) }

	  describe "GET #show" do 

	  	it "should persists @user" do
			  get :show, id: user
			  expect(assigns(:user)).to be_persisted
			end

	  	it "should assigns @user" do
	      get :show, id: user
	      expect(assigns(:user)).to eq(user)
	    end
	    
      it "should assigns @comments" do
	      get :show, id: user
	      expect(assigns(:comments)).to eq(user.comments.hash_tree)
	    end

      it "should assigns @seller_items" do
      	o =  create(:order, :user => user2)
				oi = create(:order_item, :product => product, :order => o)
	      get :show, id: user
	      expect(assigns(:seller_items).last.product_id).to eq(product.id)
	    end

	  	it "redirect_to :show view" do
	  		get :show, id: user
	  		expect(response).to render_template :show
	  	end
	  end

	  describe "GET #follow" do 
	  	it "added new user to follow list" do
	  		get :follow, id: user2
	  		expect(flash[:notice]).to eq("You add user to feed list")
	  	end 

	  	it "deleted user from follow list" do
	  		get :follow, id: user2, type: "unfollow"
	  		expect(flash[:alert]).to eq("You delete user from feed list")
	  	end 

	  	it "redirect_to :show view" do
	  		get :follow, id: user2
	  		expect(response).to redirect_to user
	  	end
	  end
	end
end

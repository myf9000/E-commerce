

require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
	context "User not logged in " do 
    describe "GET #new_session" do
      it "redirects to login page" do 
        get :edit, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end 
    end
  end

	context "User logged in" do 
		let(:user) { create(:user) }
		let(:user2) { create(:user) }
	  let(:product) { create(:product, user: user2, stock: 100) }
	  let(:order) { create(:order, user: user, status: "unsubmitted") }
		let(:order_item) { create(:order_item, product: product, order: order, quantity: 10) }

	  before { sign_in(user) }

	  describe "GET #buy" do 
	  	it "assign @order" do 
		  	get :buy, id: order_item
		  	expect(assigns(:order)).to eq(Order.last)
		  end

		  it "redirect to order" do
	  	  get :buy, id: order_item
	  	  expect(response).to redirect_to Order.last
	  	end

	  	it "buy item" do
	  		get :buy, id: order_item
	  		expect(flash[:notice]).to eq("You buyed")
	  	end 
	  end

	  describe "GET #product_orders" do 
	  	it "assign @order" do 
		  	get :product_orders, id: order_item
		  	expect(assigns(:order)).to eq(order)
		  end

		  it "return proper status" do 
		  	get :product_orders, id: order_item, type: "Proper"
		  	order.reload
		  	expect(order.status).to eq("Proper")
		  end

		  it "redirect to user" do
	  	  get :product_orders, id: order_item
	  	  expect(response).to redirect_to user
	  	end
	  end

    describe "GET #edit" do
    	it "assigns @order_item" do 
        get :edit, id: order_item
        expect(assigns(:order_item)).to eq(order_item)
      end

	    it "renders the :edit view" do
	      get :edit, id: order_item
	      expect(response).to render_template :edit
	    end
	  end

	  describe "PUT #update" do 
	  	context "if quantity will be 0" do
	  		it "destroy order_item" do
	  			oi_test = create(:order_item, product: product, :order => order)
	  			expect do
	  				put :update, id: oi_test, order_item: attributes_for(:order_item_zero)
	  			end.to change(OrderItem,:count).by(-1)
	  		end

	  		it "redirect to order path" do
		  	  put :update, id: order_item, order_item: attributes_for(:order_item_zero)
		  	  expect(response).to redirect_to Order.last
		  	end

	  	end

  		context "valid atributes" do
	  	  it "located the requested @order_item" do
	        put :update, id: order_item, order_item: attributes_for(:order_item)
	        expect(assigns(:order_item)).to eq(order_item)      
	      end
	  
	      it "changes @order_item's attributes" do
	        put :update, id: order_item, order_item: attributes_for(:order_item, quantity: 5)
	        order_item.reload
	        expect(order_item.quantity).to eq(5)
	      end
	  
	      it "redirects to the updated order_item" do
	        put :update, id: order_item, order_item: attributes_for(:order_item)
	        expect(response).to redirect_to Order.last
	      end
	  	end

	  	context "invalid atributes" do
	      it "does not change @order_item's attributes" do
	        put :update, id: order_item, order_item: attributes_for(:order_item, quantity: "lalala")
	        order.reload
	        expect(order_item.quantity).to_not eq("lalala")
	      end
	  
	      it "redirect to order" do
	        put :update, id: order_item, order_item: attributes_for(:invalid_order_item)
	        expect(response).to redirect_to Order.last
	      end
	  	end
	  end

	  describe "DELETE #destroy" do 
	  	it "assign @order" do
	  	  get :destroy, id: order_item
	  	  expect(assigns(:order)).to eq(order)
	  	end

	  	it "redirect to order path" do
	  	  get :destroy, id: order_item
	  	  expect(response).to redirect_to Order.last
	  	end

	  	it "deletes order_item" do
	  		oi_test = create(:order_item, product: product, order: order)
	  	  expect{delete :destroy, id: oi_test}.to change(OrderItem,:count).by(-1)
	  	end
	  end

	  # describe "POST #create" do 
	  # 	it "assign new @order" do
	  # 	  post :create, order_item: attributes_for(:order_item)
	  # 	  expect(assigns(:order)).to be_instance_of(Order)
	  # 	end

	  # 	it "assign new @order_item" do
	  # 	  post :create, order_item: attributes_for(:order_item)
	  # 	  expect(assigns(:order_item)).to be_instance_of(OrderItem)
	  # 	end

   #    context "with valid attributes" do 
   #      it "saves the new order_item object" do
	  #       expect do
	  #        	post :create, order_item: attributes_for(:order_item)
	  #        	order_item.reload
	  #      	end.to change(OrderItem, :count).by(1)
   #      end

   #      it "redirect to :show view " do 
   #        post :create, order_item: attributes_for(:order_item)
   #        expect(response).to redirect_to Order.last
   #      end
   #    end

   #    context "with invalid attributes" do
	  # 	  it "does not save the new order_item" do
	  # 	    expect do
	  # 	    	post :create, order_item: attributes_for(:invalid_order_item)
	  # 	    end.to_not change(OrderItem, :count)
	  # 	  end

	  # 	  it "re-render to :new view" do
	  # 	    post :create, order_item: attributes_for(:invalid_order_item)
	  # 	    expect(response).to redirect_to Order.last
	  # 	  end
	  # 	end
   #  end
	end
end
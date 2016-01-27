require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
	context "User not logged in " do 
    describe "GET #new_session" do
      it "redirects to login page" do 
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end 
    end
  end

	context "User logged in" do 
		let(:user) { create(:user) }
	  let(:product) { create(:product, user: user) }
	  let(:category) { create(:category) }
	  let(:subcategory) { create(:category, :category_child, parent_id: category.id) }

	  before { sign_in(user) }

	  describe "GET #index" do
	    it "assigns @products" do
	      get :index
	      expect(assigns(:products)).to eq([product])
	    end

	    it "should return value for parameter" do
	      get :index, search: product.title
	      expect(assigns(:products)).to eq([product])
	    end

	    it "renders the :index view" do
	      get :index
	      expect(response).to render_template :index
	    end
	  end

	  describe "GET #show" do
	  	it "assigns @category" do
	      get :show, id: product, category: category, subcategory: subcategory
	      expect(assigns(:category)).to eq(category)
	    end

	    it "assigns @subcategory" do
	      get :show, id: product, category: category, subcategory: subcategory
	      expect(assigns(:subcategory)).to eq(subcategory)
	    end

	    it "subcategory should has category" do
	    	get :show, id: product, category: category, subcategory: subcategory
	      expect(subcategory.parent_id).to eq(category.id)
	    end

	    it "assigns @product" do
	      get :show, id: product, category: category, subcategory: subcategory
	      expect(assigns(:product)).to eq(product)
	    end

	    it "renders the :show view" do
	      get :show, id: product, category: category, subcategory: subcategory
	      expect(response).to render_template :show
	    end
	  end

	  describe "GET #new" do
	  	it "assigns @product" do 
        get :new
        expect(assigns(:product)).to be_instance_of(Product)
      end

	    it "renders the :new view" do
	      get :new
	      expect(response).to render_template :new
	    end
	  end

	  describe "POST #create" do 
      context "with valid attributes" do 
        it "saves the new photo object" do
	        expect do
	         	post :create, product: attributes_for(:product) 
	       	end.to change(Product, :count).by(1)
        end

        it "redirect to :show view " do 
          post :create, product: attributes_for(:product)
          expect(response).to redirect_to Product.last
        end
      end

      context "with invalid attributes" do
	  	  it "does not save the new product" do
	  	    expect do
	  	    	post :create, product: attributes_for(:invalid_product)
	  	    end.to_not change(Product, :count)
	  	  end

	  	  it "re-render to :new view" do
	  	    post :create, product: attributes_for(:invalid_product)
	  	    expect(response).to render_template :new
	  	  end
	  	end
    end

    describe "GET #edit" do
    	it "assigns @product" do 
        get :edit, id: product
        expect(assigns(:product)).to eq(product)
      end

	    it "renders the :edit view" do
	      get :edit, id: product
	      expect(response).to render_template :edit
	    end
	  end

	  describe "PUT #update" do 
  		context "valid atributes" do
	  	  it "located the requested @product" do
	        put :update, id: product, product: attributes_for(:product)
	        expect(assigns(:product)).to eq(product)      
	      end
	  
	      it "changes @product's attributes" do
	        put :update, id: product, product: attributes_for(:product, title: "Julia")
	        product.reload
	        expect(product.title).to eq("Julia")
	      end
	  
	      it "redirects to the updated product" do
	        put :update, id: product, product: attributes_for(:product)
	        expect(response).to redirect_to product
	      end
	  	end

	  	context "invalid atributes" do
	  	  it "located the requested @product" do
	        put :update, id: product, product: attributes_for(:invalid_product)
	        expect(assigns(:product)).to eq(product)       
	      end
	  
	      it "does not change @product's attributes" do
	        put :update, id: product, product: attributes_for(:product, title: "Amy", price: nil)
	        product.reload
	        expect(product.title).to_not eq("Amy")
	      end
	  
	      it "re-renders the :edit view" do
	        put :update, id: product, product: attributes_for(:invalid_product)
	        expect(response).to render_template :edit 
	      end
	  	end
	  end

	  describe "DELETE #destroy" do 
	  	it "it redirect to root path" do
	  	  get :destroy, id: product
	  	  expect(response).to redirect_to products_path
	  	end

	  	it "deletes product" do
	  		product_test = create(:product, user: create(:user))
	  	  expect{delete :destroy, id: product_test}.to change(Product,:count).by(-1)
	  	end
	  end
	end
end
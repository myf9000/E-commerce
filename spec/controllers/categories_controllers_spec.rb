require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
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
	  before { sign_in(user) }

    describe "check privigles" do
      it "redirects to products" do 
        get :new
        expect(response).to redirect_to root_path
      end 
    end
   end

	context "Admin logged in" do 
    let(:user) { create(:user, admin: true) }
	  let(:category) { create(:category) }
	  let(:subcategory) { create(:category, :category_child, parent_id: category.id) }

	  before { sign_in(user) }

	  describe "GET #index" do
	    it "assigns @categories" do
	      get :index
	      expect(assigns(:categories)).to eq([category])
	    end

	    it "renders the :index view" do
	      get :index
	      expect(response).to render_template :index
	    end
	  end

	  describe "GET #show" do
	    it "assigns @categories" do
	      get :show, id: category
	      expect(assigns(:categories)).to include subcategory
	    end

	    it "renders the :show view" do
	      get :show, id: category
	      expect(response).to render_template :index
	    end
	  end

	  describe "GET #new" do
	  	it "assigns @category" do 
        get :new
        expect(assigns(:category)).to be_instance_of(Category)
      end

	    it "renders the :new view" do
	      get :new
	      expect(response).to render_template :new
	    end
	  end

	  describe "POST #create" do 
      context "with valid attributes" do 
        it "saves the new photo object" do
	        expect{ post :create, category:  attributes_for(:category) }.to change(Category, :count).by(1)
        end

        it "redirect to :show view " do 
          post :create, category: attributes_for(:category)
          expect(response).to redirect_to Category.last
        end
      end

      context "with invalid attributes" do
	  	  it "does not save the new category" do
	  	    expect{post :create, category: attributes_for(:invalid_category)}.to_not change(Category, :count)
	  	  end

	  	  it "re-render to :new view" do
	  	    post :create, category: attributes_for(:invalid_category)
	  	    expect(response).to render_template :new
	  	  end
	  	end
    end

    describe "GET #edit" do
    	it "assigns @category" do 
        get :edit, id: category
        expect(assigns(:category)).to eq(category)
      end

	    it "renders the :edit view" do
	      get :edit, id: category
	      expect(response).to render_template :edit
	    end
	  end

	  describe "PUT #update" do 
  		context "valid atributes" do
	  	  it "located the requested @category" do
	        put :update, id: category, category: attributes_for(:category)
	        expect(assigns(:category)).to eq(category)      
	      end
	  
	      it "changes @category's attributes" do
	        put :update, id: category, category: attributes_for(:category, name: "Julia")
	        category.reload
	        expect(category.name).to eq("Julia")
	      end
	  
	      it "redirects to the updated category" do
	        put :update, id: category, category: attributes_for(:category)
	        expect(response).to redirect_to category
	      end
	  	end

	  	context "invalid atributes" do
	  	  it "located the requested @category" do
	        put :update, id: category, category: attributes_for(:invalid_category)
	        expect(assigns(:category)).to eq(category)       
	      end
	  
	      it "does not change @category's attributes" do
	        put :update, id: category, category: attributes_for(:category, name: nil)
	        category.reload
	        expect(category.name).to_not eq("Amy")
	      end
	  
	      it "re-renders the :edit view" do
	        put :update, id: category, category: attributes_for(:invalid_category)
	        expect(response).to render_template :edit 
	      end
	  	end
	  end

	  describe "DELETE #destroy" do 
	  	it "it redirect to root path" do
	  	  get :destroy, id: category
	  	  expect(response).to redirect_to categories_path
	  	end

	  	it "deletes category" do
	  		cat_test = create(:category)
	  	  expect{delete :destroy, id: cat_test}.to change(Category,:count).by(-1)
	  	end
	  end
	end
end
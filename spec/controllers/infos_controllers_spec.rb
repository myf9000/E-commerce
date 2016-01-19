require 'rails_helper'

RSpec.describe InfosController, type: :controller do
	context "User not logged in " do 
    describe "GET #new_session" do
      it "redirects to login page" do 
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end 
    end
  end

	context "User logged in" do 
    before :each do 
      @user = create(:user)
      sign_in @user
    end 

	  let(:info) { create(:info, user: @user) }

	  describe "GET #show" do
	    it "assigns @info" do
	      get :show, id: info
	      expect(assigns(:info)).to eq(info)
	    end

	    it "renders the :show view" do
	      get :show, id: info
	      expect(response).to render_template(:show)
	    end
	  end

	  describe "GET #new" do
	  	it "assigns @info" do 
        get :new
        expect(assigns(:info)).to be_instance_of(Info)
      end

	    it "renders the :new view" do
	      get :new
	      expect(response).to render_template :new
	    end
	  end

	  describe "POST #create" do 
      context "with valid attributes" do 
        it "saves the new photo object" do
	        expect{ post :create, info:  attributes_for(:info) }.to change(Info, :count).by(1)
        end

        it "redirect to :show view " do 
          post :create, info: attributes_for(:info)
          expect(response).to redirect_to info_path(Info.last)
        end
      end

      context "with invalid attributes" do
	  	  it "does not save the new info" do
	  	    expect{post :create, info: attributes_for(:invalid_info)}.to_not change(Info, :count)
	  	  end

	  	  it "re-render to :new view" do
	  	    post :create, info: attributes_for(:invalid_info)
	  	    expect(response).to render_template :new
	  	  end
	  	end
    end

    describe "GET #edit" do
    	it "assigns @info" do 
        get :edit, id: info
        expect(assigns(:info)).to eq(info)
      end

	    it "renders the :edit view" do
	      get :edit, id: info
	      expect(response).to render_template :edit
	    end
	  end

	  describe "PUT #update" do 
  		context "valid atributes" do
	  	  it "located the requested @info" do
	        put :update, id: info, info: attributes_for(:info)
	        expect(assigns(:info)).to eq(info)      
	      end
	  
	      it "changes @info's attributes" do
	        put :update, id: info, info: attributes_for(:info, first_name: "Julia")
	        info.reload
	        expect(info.first_name).to eq("Julia")
	      end
	  
	      it "redirects to the updated info" do
	        put :update, id: info, info: attributes_for(:info)
	        expect(response).to redirect_to info
	      end
	  	end

	  	context "invalid atributes" do
	  	  it "located the requested @info" do
	        put :update, id: info, info: attributes_for(:invalid_info)
	        expect(assigns(:info)).to eq(info)       
	      end
	  
	      it "does not change @info's attributes" do
	        put :update, id: info, info: attributes_for(:info, first_name: "Amy", last_name: nil)
	        info.reload
	        expect(info.first_name).to_not eq("Amy")
	      end
	  
	      it "re-renders the :edit view" do
	        put :update, id: info, info: attributes_for(:invalid_info)
	        expect(response).to render_template :edit 
	      end
	  	end
	  end

	  describe "DELETE #destroy" do 
	  	it "it redirect to root path" do
	  	  get :destroy, id: info
	  	  expect(response).to redirect_to user_path(info.user)
	  	end

	  	it "deletes info" do
	  		info_test = create(:info, user: create(:user))
	  	  expect{delete :destroy, id: info_test}.to change(Info,:count).by(-1)
	  	end
	  end
	end
end
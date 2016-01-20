require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  context "User not logged in " do 
    describe "GET #new_session" do
      it "redirects to login page" do 
        get :create
        expect(response).to redirect_to(new_user_session_path)
      end 
    end
  end

  context "User logged in" do 
	  let(:user) { create(:user) }
	  let(:comment) { create(:comment, user: user) }
	  let(:comment_child) { create(:comment_child, user: user, parent: comment) }
	  let(:invalid_comment) { create(:invalid_comment, user: user) }

	  before { sign_in(user) }

	  describe "POST #create" do 
	  	it "check parent in comment child" do
        expect(comment_child.parent_id).to eq(comment.id)
	  	end

	    context "with valid attributes" do 
	      it "saves the new comment object" do
	        expect do 
	          post :create, comment: attributes_for(:comment) 
	        end.to change(Comment, :count).by(1)
	      end

	      it "redirects to the user" do 
	        post :create, comment: attributes_for(:comment)
	        expect(response).to redirect_to user
	      end
	    end

	    context "with invalid attributes" do
        it "does not save the new comment" do
          expect do
          	post :create, comment: attributes_for(:invalid_comment)
          end.to_not change(Comment, :count)
        end

        it "re-render to :new view" do
          post :create, comment: attributes_for(:invalid_comment)
          expect(response).to redirect_to user
        end
      end
	  end
	end
end



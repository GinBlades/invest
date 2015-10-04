require 'rails_helper'

RSpec.describe CodesController, type: :controller do

  
  describe "Standard CRUD" do
    let(:instance_code) { assigns(:code) }
    let(:base_code) { create(:code) }
    let(:static_code) { create(:code, name: 'spec-code') }
    let(:valid_attributes) { attributes_for(:code, name: 'spec-code') }
    let(:invalid_attributes) { attributes_for(:code, name: nil) }
  
    describe "GET #index" do
      it "populates an array of all @codes" do
        second_code = create :code
        get :index
        expect(assigns(:codes)).to match_array([base_code, second_code])
      end
    end
  
    describe "GET show" do
      it "assigns the requested code as @code" do
        get :show, id: base_code
        expect(instance_code).to eq(base_code)
      end
    end

    describe "GET new" do
      it "assigns a new code as @code" do
        get :new
        expect(instance_code).to be_a_new(Code)
      end
    end

    describe "GET edit" do
      it "assigns the requested code as @code" do
        get :edit, id: base_code
        expect(instance_code).to eq(base_code)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Code" do
          expect do
            post :create, code: valid_attributes
          end.to change(Code, :count).by(1)
        end

        it "assigns a newly created code as @code" do
          post :create, code: valid_attributes
          expect(instance_code).to be_a(Code)
          expect(instance_code).to be_persisted
        end

        it "redirects to the created code" do
          post :create, code: valid_attributes
          expect(response).to redirect_to(Code.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved code as @code" do
          post :create, code: invalid_attributes
          expect(instance_code).to be_a_new(Code)
        end

        it "re-renders the 'new' template" do
          post :create, code: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested code as @code" do
          put :update, id: static_code, code: valid_attributes
          static_code.reload
          expect(instance_code).to eq(static_code)
        end

        it "redirects to the code" do
          put :update, id: static_code, code: valid_attributes
          expect(response).to redirect_to(static_code)
        end
      end

      describe "with invalid params" do
        it "assigns the code as @code" do
          put :update, id: static_code, code: invalid_attributes
          expect(assigns(:code)).to eq(static_code)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_code, code: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested code" do
        new_code = create :code
        expect do
          delete :destroy, id: new_code
        end.to change(Code, :count).by(-1)
      end

      it "redirects to the code list" do
        delete :destroy, id: base_code
        expect(response).to redirect_to(codes_url)
      end
    end
  end
end

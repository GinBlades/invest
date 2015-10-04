require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do

  
  describe "Standard CRUD" do
    let(:instance_company) { assigns(:company) }
    let(:base_company) { create(:company) }
    let(:static_company) { create(:company, name: 'spec-company') }
    let(:valid_attributes) { attributes_for(:company, name: 'spec-company') }
    let(:invalid_attributes) { attributes_for(:company, name: nil) }
  
    describe "GET #index" do
      it "populates an array of all @companies" do
        second_company = create :company
        get :index
        expect(assigns(:companies)).to match_array([base_company, second_company])
      end
    end
  
    describe "GET show" do
      it "assigns the requested company as @company" do
        get :show, id: base_company
        expect(instance_company).to eq(base_company)
      end
    end

    describe "GET new" do
      it "assigns a new company as @company" do
        get :new
        expect(instance_company).to be_a_new(Company)
      end
    end

    describe "GET edit" do
      it "assigns the requested company as @company" do
        get :edit, id: base_company
        expect(instance_company).to eq(base_company)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Company" do
          expect do
            post :create, company: valid_attributes
          end.to change(Company, :count).by(1)
        end

        it "assigns a newly created company as @company" do
          post :create, company: valid_attributes
          expect(instance_company).to be_a(Company)
          expect(instance_company).to be_persisted
        end

        it "redirects to the created company" do
          post :create, company: valid_attributes
          expect(response).to redirect_to(Company.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved company as @company" do
          post :create, company: invalid_attributes
          expect(instance_company).to be_a_new(Company)
        end

        it "re-renders the 'new' template" do
          post :create, company: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested company as @company" do
          put :update, id: static_company, company: valid_attributes
          static_company.reload
          expect(instance_company).to eq(static_company)
        end

        it "redirects to the company" do
          put :update, id: static_company, company: valid_attributes
          expect(response).to redirect_to(static_company)
        end
      end

      describe "with invalid params" do
        it "assigns the company as @company" do
          put :update, id: static_company, company: invalid_attributes
          expect(assigns(:company)).to eq(static_company)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_company, company: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested company" do
        new_company = create :company
        expect do
          delete :destroy, id: new_company
        end.to change(Company, :count).by(-1)
      end

      it "redirects to the company list" do
        delete :destroy, id: base_company
        expect(response).to redirect_to(companies_url)
      end
    end
  end
end

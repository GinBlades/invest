require 'rails_helper'

RSpec.describe QuotesController, type: :controller do

  
  describe "Standard CRUD" do
    let(:instance_quote) { assigns(:quote) }
    let(:base_quote) { create(:quote) }
    let(:static_quote) { create(:quote, name: 'spec-quote') }
    let(:valid_attributes) { attributes_for(:quote, name: 'spec-quote') }
    let(:invalid_attributes) { attributes_for(:quote, name: nil) }
  
    describe "GET #index" do
      it "populates an array of all @quotes" do
        second_quote = create :quote
        get :index
        expect(assigns(:quotes)).to match_array([base_quote, second_quote])
      end
    end
  
    describe "GET show" do
      it "assigns the requested quote as @quote" do
        get :show, id: base_quote
        expect(instance_quote).to eq(base_quote)
      end
    end

    describe "GET new" do
      it "assigns a new quote as @quote" do
        get :new
        expect(instance_quote).to be_a_new(Quote)
      end
    end

    describe "GET edit" do
      it "assigns the requested quote as @quote" do
        get :edit, id: base_quote
        expect(instance_quote).to eq(base_quote)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Quote" do
          expect do
            post :create, quote: valid_attributes
          end.to change(Quote, :count).by(1)
        end

        it "assigns a newly created quote as @quote" do
          post :create, quote: valid_attributes
          expect(instance_quote).to be_a(Quote)
          expect(instance_quote).to be_persisted
        end

        it "redirects to the created quote" do
          post :create, quote: valid_attributes
          expect(response).to redirect_to(Quote.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved quote as @quote" do
          post :create, quote: invalid_attributes
          expect(instance_quote).to be_a_new(Quote)
        end

        it "re-renders the 'new' template" do
          post :create, quote: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested quote as @quote" do
          put :update, id: static_quote, quote: valid_attributes
          static_quote.reload
          expect(instance_quote).to eq(static_quote)
        end

        it "redirects to the quote" do
          put :update, id: static_quote, quote: valid_attributes
          expect(response).to redirect_to(static_quote)
        end
      end

      describe "with invalid params" do
        it "assigns the quote as @quote" do
          put :update, id: static_quote, quote: invalid_attributes
          expect(assigns(:quote)).to eq(static_quote)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_quote, quote: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested quote" do
        new_quote = create :quote
        expect do
          delete :destroy, id: new_quote
        end.to change(Quote, :count).by(-1)
      end

      it "redirects to the quote list" do
        delete :destroy, id: base_quote
        expect(response).to redirect_to(quotes_url)
      end
    end
  end
end

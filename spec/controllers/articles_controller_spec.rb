require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  
  describe "Standard CRUD" do
    let(:instance_article) { assigns(:article) }
    let(:base_article) { create(:article) }
    let(:static_article) { create(:article, name: 'spec-article') }
    let(:valid_attributes) { attributes_for(:article, name: 'spec-article') }
    let(:invalid_attributes) { attributes_for(:article, name: nil) }
  
    describe "GET #index" do
      it "populates an array of all @articles" do
        second_article = create :article
        get :index
        expect(assigns(:articles)).to match_array([base_article, second_article])
      end
    end
  
    describe "GET show" do
      it "assigns the requested article as @article" do
        get :show, id: base_article
        expect(instance_article).to eq(base_article)
      end
    end

    describe "GET new" do
      it "assigns a new article as @article" do
        get :new
        expect(instance_article).to be_a_new(Article)
      end
    end

    describe "GET edit" do
      it "assigns the requested article as @article" do
        get :edit, id: base_article
        expect(instance_article).to eq(base_article)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Article" do
          expect do
            post :create, article: valid_attributes
          end.to change(Article, :count).by(1)
        end

        it "assigns a newly created article as @article" do
          post :create, article: valid_attributes
          expect(instance_article).to be_a(Article)
          expect(instance_article).to be_persisted
        end

        it "redirects to the created article" do
          post :create, article: valid_attributes
          expect(response).to redirect_to(Article.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved article as @article" do
          post :create, article: invalid_attributes
          expect(instance_article).to be_a_new(Article)
        end

        it "re-renders the 'new' template" do
          post :create, article: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested article as @article" do
          put :update, id: static_article, article: valid_attributes
          static_article.reload
          expect(instance_article).to eq(static_article)
        end

        it "redirects to the article" do
          put :update, id: static_article, article: valid_attributes
          expect(response).to redirect_to(static_article)
        end
      end

      describe "with invalid params" do
        it "assigns the article as @article" do
          put :update, id: static_article, article: invalid_attributes
          expect(assigns(:article)).to eq(static_article)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_article, article: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested article" do
        new_article = create :article
        expect do
          delete :destroy, id: new_article
        end.to change(Article, :count).by(-1)
      end

      it "redirects to the article list" do
        delete :destroy, id: base_article
        expect(response).to redirect_to(articles_url)
      end
    end
  end
end

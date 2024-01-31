require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "GET #index" do
    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should render index page" do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "GET #new" do
    it "returns a 200 response" do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe "POST #create" do
    context "when the book is saved successfully" do
      it "responds with JSON indicating success" do
        allow(Book).to receive(:new).and_return(double(save: true))
        post :create, params: { book: { title: "Title", author: "Author", link: "Link", image: "Image", price: 10.0 } }
        expect(response.body).to eq({ status: :true }.to_json)
      end
    end

    context "when the book fails to save" do
      it "returns 422 unprocessable entity with error message" do
        allow(Book).to receive(:new).and_return(double(save: false))
        post :create, params: { book: { title: "Title", author: "Author", link: "Link", image: "Image", price: 10.0 } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq("Failed to add to wishlist")
      end
    end
  end
end

require './spec/spec_helper'

describe UsersController do

  before do
    @order = FactoryGirl.create(:order)
    @user = FactoryGirl.create(:user)
    request.env["HTTP_REFERER"] = root_path
    session[:user_id] = @user.id
  end

  teardown do
    User.destroy_all
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "#show" do
    xit "responds to GET" do
      get :show, {:id => "8"}
      expect(response.body).to eq "<html><body>You are being <a href=\"http://test.host/\">redirected</a>.</body></html>"
    end

    it "requires the :id parameter" do
      expect { get :show }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "#create" do
    context "creating a registered user" do
      it "creates a registered user" do
        post :create, user: {
          full_name: "luke",
          email: "luke@luke.com",
          password: "asdf",
          password_confirmation: "asdf"
        }
        expect(User.last.full_name).to eq("luke")
        expect(response).to be_redirect
        expect(:flash).to_not be_nil
        expect(User.last.guest).to eq(false)
      end
    end

    context "creating a guest" do
      it "creates a guest" do
        post :create, user: {
          full_name: "lala", email: "luke@luke.com", guest: 'true' }
        expect(User.last.full_name).to eq("lala")
        expect(response).to be_redirect
        expect(:flash).to_not be_nil
      end
    end
  end

  describe "#update" do
    it "responds to PUT" do
      session[:user_id] = @user.id
      put :update, :user => { full_name: "darth vader",
        email: "lukesgottheforce@luke.com",
        password: "asdfmeh",
        password_confirmation: "asdfmeh" }
      expect(response).to be_redirect
      user = User.find_by(id: @user.id)
      expect(user.full_name).to eq("darth vader")
      expect(:flash).to_not be_nil
    end
  end

  describe "#destroy" do
    it "responds to DELETE" do
      session[:user_id] = @user.id
      delete :destroy, id: 6
      expect(response).to be_redirect
      expect(:flash).to_not be_nil
    end
  end

   it "requires the :id parameter" do
      expect { delete :destroy }.to raise_error(ActionController::RoutingError)
    end
end


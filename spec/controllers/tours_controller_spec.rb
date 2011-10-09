require 'spec_helper'

describe ToursController do
  render_views

  describe "GET 'index'" do
    before(:each) do
      @user = Factory(:user)
      10.times do 
        f = Factory(:tour, :user => @user)
      end
      10.times do 
        f = Factory(:tour)
      end
    end

    it "should be successful" do
      # TODO: Why is this giving a nilClass error?
      get :index
      response.should be_success
    end

    describe "access control" do
      it "should block create" do
        #TODO: This won't be true when we support anonymous tours
        # OR we could have it to use an anonymous user account
        post :create
        response.should redirect_to(signin_path)
      end

      it "should block destroy" do
        post :destroy, :id => 1
        response.should redirect_to(signin_path)
      end
    end

    describe "POST 'create'" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end

      describe "failure" do
        before(:each) do
          @attr = { :name => "" }
        end

        it "should not create a tour" do
          lambda do
            post :create, :tour => @attr
          end.should_not change(Tour, :count)
        end

        it "should render the home page" do
          post :create, :tour => @attr
          response.should render_template('pages/home')
        end
      end

      describe "success" do
        before(:each) do
          @attr = { :name => "A tour", 
                    :cost => 10, 
                    :duration => 45,
                    :desc => "description"}
        end

        it "should create a tour" do
          #Actually, this probably shouldn't work, since I'm not 
          # creating a stop to go with it
          lambda do
            post :create, :tour => @attr
          end.should change(Tour, :count).by(1)
        end

        it "should redirect to the home page" do
          post :create, :tour => @attr
          response.should redirect_to(tour_path(assigns(:tour)))
        end

        it "should have a flash message" do
          post :create, :tour => @attr
          flash[:success].should =~ /tour created/i
        end
      end
    end
  end
end

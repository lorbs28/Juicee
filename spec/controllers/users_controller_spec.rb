require 'spec_helper'

describe UsersController do
    render_views

    before(:each) do
        @base_title = "Juicee!"
    end

    ##########################
    # Controller: Users
    # Action: 'index'
    # Test to see if:
    # - 'index' is able to be retrieved after being signed in
    ##########################
    #describe "GET 'index'" do
    #
    #    before(:each) do
    #      # Use the factory for user
    #      @user = Factory(:user)
    #      # Sign in for the test or else your tests won't work
    #      test_sign_in(@user)
    #    end
    #
    #    it "should be successful" do
    #        get :index, :id => @user
    #      response.should be_success
    #    end
    #end


    ##########################
    # Controller: Users
    # Action: 'new'
    # Test to see if:
    # - 'new' is able to be retrieved
    ##########################
    describe "GET 'new'" do

      it "should be successful" do
          get 'new'
        response.should be_success
      end
    end

    ##########################
    # Controller: Users
    # Action: 'create'
    # Test to see if:
    # -- For "failure"
    # - it fails to create a user when the fields are empty
    # - the 'register' page has the right title
    # - if renders the 'register' page
    # -- For "success"
    # - it successfully creates a user when all fields are filled in
    #   and meets specifications
    # - redirects the newly registered user to the user_path, which is just
    #   'index' view
    # - it has a welcome message
    # - the user is signed in automatically after registering
    ##########################
    describe "POST 'create'" do
        describe "failure" do

            before(:each) do
                @attr = { :first_name => "", :last_name => "", :email => "",
                          :user_name => "",
                          :password => "", :password_confirmation => "" }
            end

            it "should not create a user" do
              lambda do
                post :create, :user => @attr
              end.should_not change(User, :count)
            end

            it "should have the right title" do
              post :create, :user => @attr
              response.should have_selector("title",
                  :content => @base_title + " | Register")
            end

            it "should render the 'new' page" do
              post :create, :user => @attr
              response.should render_template('new')
            end
        end

        describe "success" do

            before(:each) do
              @attr = { :first_name => "Marky", :last_name => "Mark", :email => "mmark@gmail.com",
                          :user_name => "marky001",
              :password => "foobar1", :password_confirmation => "foobar1" }
            end

            it "should create a user" do
              lambda do
                post :create, :user => @attr
              end.should change(User, :count).by(1)
            end

            it "should redirect to the user show page" do
              post :create, :user => @attr
              response.should redirect_to(user_path(assigns(:user)))
            end
        #
        #    it "should have a welcome message" do
        #      post :create, :user => @attr
        #      flash[:success].should =~ /Welcome Marky, you are now registered to use Juicee!/i
        #    end
        #
        #    it "should sign the user in" do
        #      post :create, :user => @attr
        #      controller.should be_signed_in
        #    end
        end
    end

    ##########################
    # Controller: Users
    # Action: 'edit'
    # Test to see if:
    # - 'edit' is able to be retrieved after success login
    # - 'edit' view has the right title
    ##########################
    #describe "GET 'edit'" do
    #
    #    before(:each) do
    #      @user = Factory(:user)
    #      test_sign_in(@user)
    #    end
    #
    #    it "should be successful" do
    #      get :edit, :id => @user
    #      response.should be_success
    #    end
    #
    #    it "should have the right title" do
    #      get :edit, :id => @user
    #      response.should have_selector("title",
    #          :content => @base_title + " | Edit Profile")
    #    end
    #end

    ##########################
    # Controller: Users
    # Action: 'update'
    # Test to see if:
    # -- For "failure"
    # - the 'edit' page should render if all fields are left blank
    # - the 'edit' page should have the right title
    # -- For "success"
    # - the user's information should update with all fields filled out
    # - the user is redirected back to 'index'
    # - a flash message appears telling the user that their update was successful
    ##########################
    #describe "PUT 'update'" do
    #
    #before(:each) do
    #  @user = Factory(:user)
    #  test_sign_in(@user)
    #end
    #
    #    describe "failure" do
    #
    #      before(:each) do
    #          @attr = { :first_name => "", :last_name => "", :email => "",
    #                    :user_name => "", :password => "",
    #                    :password_confirmation => "" }
    #      end
    #
    #      it "should render the 'edit' page" do
    #        put :update, :id => @user, :user => @attr
    #        response.should render_template('edit')
    #      end
    #
    #      it "should have the right title" do
    #        put :update, :id => @user, :user => @attr
    #        response.should have_selector("title",
    #            :content => @base_title + " | Edit Profile")
    #      end
    #    end
    #    describe "success" do
    #
    #      before(:each) do
    #          @attr = { :first_name => "Bobby", :last_name => "World", :email => "b.world@hotmail.com",
    #                :password => "foobar1",
    #                :password_confirmation => "foobar1" }
    #      end
    #
    #      it "should change the user's attributes" do
    #        put :update, :id => @user, :user => @attr
    #        @user.reload
    #        @user.first_name.should  == @attr[:first_name]
    #        @user.last_name.should == @attr[:last_name]
    #        @user.email.should == @attr[:email]
    #      end
    #
    #      it "should redirect to the user show page" do
    #        put :update, :id => @user, :user => @attr
    #        response.should redirect_to(user_path(@user))
    #      end
    #
    #      it "should have a flash message" do
    #        put :update, :id => @user, :user => @attr
    #        flash[:success].should =~ /updated/
    #      end
    #    end
    #end

    ##########################
    # Controller: Users
    # Action: 'correct_user'
    # Test to see if:
    # -- For "non-signed-in users"
    # - access is denied to the edit page
    # - access is denied to the index page
    # - access is denied to the update action
    # -- For "signed-in users"
    # - access is denied to change the user profile if users don't match
    # - access is denied to the update action if the users don't match
    ##########################

    #describe "authentication of index/edit/update pages" do
    #
    #    before(:each) do
    #      @user = Factory(:user)
    #    end
    #
    #    describe "for non-signed-in users" do
    #
    #      it "should deny access to 'edit'" do
    #        get :edit, :id => @user
    #        response.should redirect_to(signin_path)
    #      end
    #
    #      it "should deny access to 'index'" do
    #          get :index, :id => @user
    #        response.should redirect_to(signin_path)
    #      end
    #
    #      it "should deny access to 'update'" do
    #        put :update, :id => @user, :user => {}
    #        response.should redirect_to(signin_path)
    #      end
    #    end
    #
    #    describe "for signed-in users" do
    #
    #      before(:each) do
    #          wrong_user = Factory(:user, :user_name => "user#{rand(1000).to_s}", :email => "error@gmail.com")
    #        test_sign_in(wrong_user)
    #      end
    #
    #      it "should require matching users for 'edit'" do
    #        get :edit, :id => @user
    #        response.should redirect_to(root_path)
    #      end
    #
    #      it "should require matching users for 'update'" do
    #        put :update, :id => @user, :user => {}
    #        response.should redirect_to(root_path)
    #      end
    #    end
    #end




end


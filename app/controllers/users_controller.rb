class UsersController < ApplicationController
    before_filter :authenticate, :only => [:index, :edit, :update]
    before_filter :correct_user, :only => [:edit, :update]

    def index
        @user = current_user

        # If current user is signed in, then render the 'index' view
        if signed_in?
            @bookmark = Bookmark.new
            @title = [@user.first_name, @user.last_name].join(" ")
            render 'index'
        else
            # Else if the current user is not signed in, redirect the user
            # to the signin page at 'sessions/new'
            redirect_to signin_path
        end

    end
    # This action is called to display the current user's information on the
    # 'show' view
    def show
          @user = User.find(params[:id])
          @title = [@user.first_name, @user.last_name].join(" ")
          #@bookmarks = @user.bookmarks(:page => params[:page])
    end

    def new
      @title = "Register"
      @user = User.new

        respond_to do |format|
          format.html
          format.json { render json: @user }
        end
    end

    # This action is called to create a new user and save them to the database
    def create
      @user = User.new(params[:user])

      # If the user was saved to the database, then sign in the user automatically
      # and flash a message telling the user that they are now registered
      if @user.save
          sign_in @user
          flash[:success] = "Welcome #{@user.first_name}, you are now registered to use Juicee!"
          redirect_to @user
      else
          # If the user was not saved to the database, render the registration page again
          @title = "Register"
          render 'new'
      end
    end

    # This action is called to let the current user update their profile
    def edit
        @title = "Edit Profile"
        @user = User.find(params[:id])
    end

    # This action is called by the form for editing the user profile
    def update
      @user = User.find(params[:id])

      # If the update was successful, then flash a message telling the user that
      # their profile was updated
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated."
        redirect_to @user
      else
          # If the update was not successful, then render the 'edit' page
          @title = "Edit Profile"
          render 'edit'
      end
    end

    private

    # Private action that assures that only the correct users can get unto the right page.
    # Used at the beginning of this controller in the before_filter
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end

class UsersController < ApplicationController

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
          #sign_in @user
          flash[:success] = "Welcome #{@user.first_name}, you are now registered to use Juicee!"
          redirect_to @user
      else
          # If the user was not saved to the database, render the registration page again
          @title = "Register"
        render 'new'
      end
    end


end

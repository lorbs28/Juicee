class SessionsController < ApplicationController

    # This action is for the 'signin' path, a.k.a. it's where users are
    # redirected back to if they are not signed in when trying to view pages
    # on the application other than register
  def new
      @title = "Sign In"
  end

  def create

      # Calls authenticate then passes to a local variable called user
      user = User.authenticate(params[:session][:user_name],
                           params[:session][:password])

      # Test to see if the user variable returns nil and if it does
      # then flash a message telling the user that the username/password
      # combination are invalid
      if user.nil?
          flash.now[:error] = "Invalid username/password combination."
          @title = "Sign In"
          render 'new'
      else
          # If the user variable does NOT return nil, then sign in the user
          # and redirect it back to 'index'
          sign_in user
          #redirect_to user
          redirect_back_or user
      end
  end

  # This action signs out the user when they click on the 'signout' link
  # on the navigation menu
  def destroy
    sign_out
    redirect_to root_path
  end


end


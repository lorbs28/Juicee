class BookmarksController < ApplicationController

  #before_filter :authenticate, :only => [:new, :index, :create, :destroy]
  #before_filter :authorized_user, :only => :destroy

  before_filter :authenticate, :only => [:index, :new, :create, :destroy]
  before_filter :authorized_user, :only => [:edit, :destroy]

  def new
      @title = "Register"
      @bookmark = Bookmark.new

        respond_to do |format|
          format.html
          format.json { render json: @user }
        end
  end

  def create
    @bookmark  = current_user.bookmarks.build(params[:bookmark])
    if @bookmark.save
      flash[:success] = "Bookmark created!"
      redirect_to @bookmark
    else
        @title = "Create bookmark"
        render 'new'
    end
  end

  def destroy
    @bookmark.destroy
    redirect_back_or @bookmark
  end

  def index
    @title = [current_user.first_name, current_user.last_name].join(" ")
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    @title = @bookmark.name
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update_attributes(params[:bookmark])
      flash[:success] = "Bookmark updated!"
      redirect_to @bookmark
    else
        @title = "Edit bookmark"
        render 'edit'
    end
  end

  private

    def authorized_user
      @bookmark = current_user.bookmarks.find_by_id(params[:id])
      redirect_to root_path if @bookmark.nil?
    end
end

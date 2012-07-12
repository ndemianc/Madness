class UsersController < ApplicationController
  include ApplicationHelper 
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample application"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def delete

  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # it works
      redirect_to @user, :flash => { :success => "Profile updated." }
    else
      # it fails
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    redirect_to users_path, :flash => { :success => "User #{user.name} destroyed."}
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      user = User.find(params[:id])
      debugger
      redirect_to(root_path) if (!current_user.admin? || current_user?(user))
    end

end

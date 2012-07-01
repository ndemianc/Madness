class UsersController < ApplicationController
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

end

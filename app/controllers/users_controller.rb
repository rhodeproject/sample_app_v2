class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    if signed_in?
      flash[:success] = "You are already signed in."
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    if signed_in?
      flash[:success] = "You are already signed in."
      redirect_to root_path
    end
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to The Rhode Project!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @remove =  User.find(params[:id])
    if @remove == current_user
      flash[:success] = "You cannot remove yourself"
      redirect_to users_path
    else
      @remove.destroy  unless @remove == current_user
      flash[:success] = "User #{@remove.name} removed."
      redirect_to users_path
    end

  end

  #Private Functions
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end



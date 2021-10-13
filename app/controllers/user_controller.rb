class UserController < ApplicationController

  # before_action :authorize_admin, except: [:index, :show]

  def index
    @user = User.all
    authorize @user
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    flash[:notice] = "New user created successfully"
    redirect_to user_index_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.update(user_params)
    # @user.current_password = params[:current_password]
    flash[:notice] = "User updated successfully"
  end

  def delete
    @user = User.find(params[:id])
    flash[:notice] = "User deleted successfully"
    @user.destroy
    redirect_to user_index_path
  end

  def user_params
    params.require(:user).permit(:user, :password, :password_confirmation, :role)
  end

  private

  # def authorize_admin
  #   if current_user.role != "1"
  #     redirect_to root_path, alert: 'Admins only!'
  #   end
  # end

end

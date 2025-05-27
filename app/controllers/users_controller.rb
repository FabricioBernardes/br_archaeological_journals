class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: [:edit_role, :update_role, :edit, :update]

  def index
    @users = User.all.order(:email)
  end

  def edit_role
  end

  def update_role
    if @user.update(user_params)
      redirect_to edit_user_registration_path(@user), notice: 'Role atualizada com sucesso.'
    else
      render :edit_role, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to users_path, alert: 'Edição completa de dados de outros usuários não é permitida.'
  end

  def update
    redirect_to users_path, alert: 'Edição completa de dados de outros usuários não é permitida.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end

  def require_admin
    return if current_user&.admin?

    redirect_to root_path, alert: 'Acesso restrito a administradores.'
  end
end

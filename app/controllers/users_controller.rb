class UsersController < ApplicationController
  # apenas o próprio usuário vai poder editar o seu perfil
  before_action :can_change, :only => [:edit, :update]
  # permite que a tela de cadastro seja acessada sem login
  before_action :require_no_authentication, :only => [:new, :create]
  # ação destroy apenas para usuários logados
  before_action :require_authentication, :only => :destroy

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    # retorna um hash com todos os parâmetros enviados pelo usuário, seja via formulário ou via query string.
    @user = User.new(user_params)
    if @user.save
      #envia email ao usuário confirmando o cadastro
      SignupMailer.confirm_email(@user).deliver
      redirect_to @user,
                  :notice => 'Cadastro realizado com sucesso!'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, :notice => 'Cadastro atualizado com sucesso!'
    else
      render :update
    end
  end

  def can_change
    unless user_signed_in && current_user == user
      redirect_to user_path(params[:id])
    end
  end

  def user
    @user ||= User.find(params[:id])
  end

  # http://guides.rubyonrails.org/v3.2.9/security.html
  private
  def user_params
    params.require(:user).permit(:bio, :email, :full_name, :location, :password, :password_confirmation)
  end
end
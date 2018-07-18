class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    # retorna um hash com todos os parâmetros enviados pelo usuário, seja via formulário ou via query string.
    @user = User.new(allowed_params)
    if @user.save
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
    if @user.update_attributes(allowed_params)
      redirect_to @user, :notice => 'Cadastro atualizado com sucesso!'
    else
      render :update
    end
  end

  # http://guides.rubyonrails.org/v3.2.9/security.html
  private
  def allowed_params
    params.require(:user).permit(:bio, :email, :full_name, :location, :password, :password_confirmation)
  end
end
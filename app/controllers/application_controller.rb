class ApplicationController < ActionController::Base
  # previne a vulnerabilidade Cross-Site Request Forgery
  # mais detalhes em https://nvisium.com/blog/2014/09/10/understanding-protectfromforgery.html
  protect_from_forgery

  # before_filter substituido por before_action no rails 5
  before_action :set_locale

  delegate :current_user, :user_signed_in?, :to => :user_session
  helper_method :current_user, :user_signed_in?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # usando o idioma padrão do application.rb
  def default_url_options
    { :locale => I18n.locale }
  end

  # verifica sessão do usuário
  def user_session
    UserSession.new(session)
  end

  # verifica se usuário necessita de autenticação
  def require_authentication
    unless user_signed_in?
      redirect_to new_user_sessions_path,
                  :alert => t('flash.alert.needs_login')
    end
  end

  # e caso o usuário necessite, o leva a página de login
  def require_no_authentication
    redirect_to root_path if user_signed_in?
  end

end

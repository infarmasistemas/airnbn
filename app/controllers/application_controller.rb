class ApplicationController < ActionController::Base
  # previne a vulnerabilidade Cross-Site Request Forgery
  # mais detalhes em https://nvisium.com/blog/2014/09/10/understanding-protectfromforgery.html
  protect_from_forgery

  # before_filter substituido por before_action no rails 5
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # usando o idioma padrão do application.rb
  def default_url_options
    { :locale => I18n.locale }
  end

end

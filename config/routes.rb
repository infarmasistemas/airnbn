Rails.application.routes.draw do

  LOCALES = /en|pt\-BR/

  scope "(:locale)", :locale => LOCALES do
    resources :rooms
    resources :users
    resource :user_confirmation, :only => [:show]
  end

  # necessário especificar método em que irá pegar o symbol :locale
  # https://stackoverflow.com/questions/19798466/rails-4-you-should-not-use-the-match-method-in-your-router-without-specifying
  match '/:locale' => 'home#index', :via => [:get], :locale => LOCALES
  root :to => "home#index"
end

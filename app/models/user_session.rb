class UserSession
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Translation
  extend ActiveModel::Naming
  attr_accessor :email, :password
  validates_presence_of :email, :password

  def initialize(session, attributes={})
    @session = session
    @email = attributes[:email]
    @password = attributes[:password]
  end

  # verifica a entrada de dados do usuário
  def authenticate
    user = User.authenticate(@email, @password)
    if user.present?
      store(user)
    else
      errors.add(:base, :invalid_login)
      false
    end
  end

  # salva a sessão do usuário
  def store(user)
    @session[:user_id] = user.id
  end

  def persisted?
    false
  end
end
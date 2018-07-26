class User < ApplicationRecord

  # verifica se os dados estão presentes
  validates_presence_of :email, :full_name, :location
  # verifica o tamanho da bio
  validates_length_of :bio, :minimum => 30, :allow_blank => false
  # verifica através de uma expressão regular
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  # verifica se o mesmo é unico
  validates_uniqueness_of :email

  # mostra mais de um quarto vinculado aquele usuario
  has_many :rooms

  # BCrypt
  has_secure_password

  # verifica se o usuário foi corfirmado por email
  # The scope's body needs to wrapped in something callable like a Proc or Lambda:
  # https://stackoverflow.com/questions/28951671/argument-error-the-scope-body-needs-to-be-callable
  scope :confirmed, -> { where('confirmed_at IS NOT NULL') }

  # gerando tokens para confirmação de criação de conta do usuário
  before_create :generate_token
  def generate_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  # registra o momento da confirmação e limpa o token do usuário
  def confirm!
    return if confirmed?
    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end

  # verifica se usuário foi confirmado, caso sim retorna true
  def confirmed?
    confirmed_at.present?
  end

  # faz a verificacao do email e senha, válido retorna, se não for
  # retorna nil
  def self.authenticate(email, password)
    confirmed.
        find_by_email(email).
        try(:authenticate, password)
  end

end

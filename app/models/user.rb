class User < ApplicationRecord
  # verifica se os dados estão presentes
  validates_presence_of :email, :full_name, :location
  # verifica o tamanho da bio
  validates_length_of :bio, :minimum => 30, :allow_blank => false
  # verifica através de uma expressão regular
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  # verifica se o mesmo é unico
  validates_uniqueness_of :email

  # BCrypt
  has_secure_password

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
end

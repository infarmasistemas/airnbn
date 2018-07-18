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
end

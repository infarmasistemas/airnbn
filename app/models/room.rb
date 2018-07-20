class Room < ApplicationRecord
  belongs_to :user

  # validações do modelo room
  validates_presence_of :title, :location, :description
  validates_length_of :title, :minimum => 10, :allow_blank => false
  validates_length_of :location, :minimum => 20, :allow_blank => false
  validates_length_of :description, :minimum => 30, :allow_blank => false

  def complete_name
    "#{title}, #{location}"
  end

end

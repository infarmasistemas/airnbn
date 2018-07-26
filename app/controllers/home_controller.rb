class HomeController < ApplicationController
  def index
    # limita a visualização de quartos para 3
    # @rooms = Room.order(created_at: :desc).limit(2)
    @rooms = Room.order(created_at: :desc)
  end
end
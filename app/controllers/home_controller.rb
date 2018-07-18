class HomeController < ApplicationController
  def index
    # limita a visualização de quartos para 3
    @rooms = Room.limit(3)
  end
end
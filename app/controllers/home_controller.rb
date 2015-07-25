class HomeController < ApplicationController
  def index
    @maps = Map.all
  end
end
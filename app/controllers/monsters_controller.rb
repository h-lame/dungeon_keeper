class MonstersController < ApplicationController
  def new
    @monster = Monster.new
  end
end

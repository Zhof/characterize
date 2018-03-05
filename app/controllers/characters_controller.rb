class CharactersController < ApplicationController

  def new
    @character = Character.new
  end

  def create

  end

  def show

  end

  def index

  end

  def destroy

  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name, :race, :class, :location)
  end
end

class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :destroy]

  def new
    @character = Character.new
    file = File.read(Rails.root.to_s + "/db/text.json")
    json = JSON.parse(file)

    @races = json["races"]
    @jobs = json["jobs"]
    @alignments = json["alignments"]
    @backgrounds = json["backgrounds"]

    @starting_words = CharacterGenerator.new(2).fetch_possibilities
  end

  def create
    @character = Character.new(character_params)

    if current_user
      @character.user = current_user
      if @character.save
        redirect_to character_path(@character)
      else
        redirect_to root, notice: "Something went wrong, please try again"
      end
    else
      redirect_to new_user_session
    end
  end

  def show
  end

  def index
    @user = current_user
    @characters = Character.where(user: current_user)
  end

  def destroy
    @character.destroy
    redirect_to characters_path
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name, :race, :job, :location, :trait, :quirk, :story)
  end

end

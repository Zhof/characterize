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
        redirect_to characters_path
      else
        redirect_to root_path, notice: "Something went wrong, please try again"
      end
    else
      redirect_to new_user_session
    end
  end

  def show
    @images = [
      "characters/dragonborn_wizard.png",
      "characters/dwarf_cleric.png",
      "characters/dwarf_fighter.png",
      "characters/elf_bard.png",
      "characters/elf_druid.png",
      "characters/gnome_ranger.png",
      "characters/half_elf_wizard.png",
      "characters/half_orc_fighter.png",
      "characters/human.png",
      "characters/human_barbarian.png",
      "characters/human_sorcerer.png",
      "characters/tiefling_warlock.png"
      ].sample
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
    if params[:trait]
      params.require(:character).permit(:race, :job, :location, :trait, :quirk, :story)
    else
      {
        :name => params[:name],
        :race => params[:race],
        :job => parmams[:job],
        :alignment => params[:alignment],
        :background => params[:background],
        :story => params[:story],
        :full => true
      }
    end
  end

end

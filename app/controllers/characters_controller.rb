class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :destroy, :share, :buy_pint]

  def new
    @character = Character.new
    file = File.read(Rails.root.to_s + "/db/text.json")
    json = JSON.parse(file)

    @races = json["races"]
    @jobs = json["jobs"]
    @alignments = json["alignments"]
    @backgrounds = json["backgrounds"]

    @starting_words = Generator.fetch_possibilities
  end

  def create
    @character = Character.new(character_params)
    @character.photo = "characters/#{character_params[:race]}_#{character_params[:job]}.png"
    @character.rating = 0

    if current_user
      @character.user = current_user
      if @character.save!
        redirect_to characters_path
      else
        redirect_to root_path, notice: "Something went wrong, please try again"
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

  def tavern
    @user = current_user
    @characters = Character.where(shared: true).order(rating: :desc)
  end

  def share
    if @character.shared
        redirect_to character_path(@character), alert: "This character is already at the Tavern"
    else
      @character.shared = true
      @character.save
      redirect_to tavern_path
    end
  end

  def buy_pint
    if @character.rating
      @character.rating += 1
    else
      @character.rating = 1
    end

    @character.save
    redirect_to character_path
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
    if params[:character] && params[:character][:trait]
      params.require(:character).permit(:name, :race, :job, :location, :trait, :quirk, :story, :alignment, :background, :personality_traits, :bond, :ideal, :flaw)
    else
      {
        :name => params[:name],
        :race => params[:race],
        :job => params[:job],
        :alignment => params[:alignment],
        :background => params[:background],
        :personality_traits => params[:personality_traits],
        :ideal => params[:ideal],
        :bond => params[:bond],
        :flaw => params[:flaw],
        :story => params[:story],
        :full => true
      }
    end
  end
end

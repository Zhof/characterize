require 'json'

class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :destroy]

  def new
    @character = Character.new
  end

  def create

    def load_attributes(file_name)
      file = File.read(file_name)
      text = JSON.parse(file)

      @attributes = {
        templates: text["templates"],
        names: text["names"],
        traits: text["traits"],
        races: text["races"],
        jobs: text["jobs"],
        locations: text["locations"],
        quirks: text["quirks"]
      }
    end

    def generate
      attributes = load_attributes('text.json')
      template = attributes[:templates].sample

      @character_params = {
        'name' => attributes[:names].sample,
        'trait' => attributes[:traits].sample,
        'race' => attributes[:races].sample,
        'job' => attributes[:jobs].sample,
        'location' => attributes[:locations].sample,
        'quirk' => attributes[:quirks].sample
       }

      template.gsub(/trait|race|job|location|quirk/) { |match| @character_params[match] }
    end

    @sentence = generate
    @character = Character.new(@character_params)
    @character.save
    # if current_user
    #   @character.user = current_user
    #   if @character.save
    #     notice: "Succes, character save"
    #   else
    #     notice: "Something went wrong, please try again"
    #   end
    # else
    #   redirect_to new_user_session
    # end
  end

  def show

  end

  def index
    @user = current_user
    @characters = Character.where(user: current_user)
  end

  def destroy
    @character.destroy
    redirect_to characters_path(current_user)
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

end

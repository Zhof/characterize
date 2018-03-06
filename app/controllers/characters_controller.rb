require 'json'

class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :destroy]

  def new
    @character = Character.new
  end

  def create
    @sentence = generate
    @character = Character.new(@character_params)
    @character.story = @sentence

    if current_user
      @character.user = current_user
      if @character.save
        redirect_to @character
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
    redirect_to characters_path(current_user)
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

  def load_attributes(file_name)
    file = File.read(file_name)
    text = JSON.parse(file)

    attributes = {
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
    path = Rails.root.to_s + "/public/text.json"
    attributes = load_attributes(path)
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

end

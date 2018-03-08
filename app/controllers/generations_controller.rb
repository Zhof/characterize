class GenerationsController < ApplicationController
  def new
    @character_params = generate_attributes
    @character = Character.new(@character_params)
  end

  def build
    #build will be called when user has selected their other character attributes
    #Should have name, race, alignment, background, job in params
    # character_params = params etc.
    @character = Character.new(character_params)
    #While story is being generated
    generate_story
    #When user is done creating story, save story as @character.story
  end

  private

  def generate_story
    path = Rails.root.to_s + "/db/text.json"
    generator = Generator.new(path, 2)
    suggested_words = generator.fetch_possibilities(params[:word])

    response = {
      word: params[:word]
      suggestions: suggested_words
    }

    render json: response
  end

  def generate_attributes
    path = Rails.root.to_s + "/db/text.json"
    attributes = load_attributes(path)
    template = attributes[:templates].sample

    character_params = {
      'name' => attributes[:names].sample,
      'trait' => attributes[:traits].sample,
      'race' => attributes[:races].sample,
      'job' => attributes[:jobs].sample,
      'location' => attributes[:locations].sample,
      'quirk' => attributes[:quirks].sample
    }

    character_params[:story] = template.gsub(/trait|race|job|location|quirk/) { |match| character_params[match] }

    character_params
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
end

class GenerationsController < ApplicationController
  def new
    @character_params = generate_attributes
    @character = Character.new(@character_params)
    @character.photo = "characters/#{@character_params['race']}_#{@character_params['job']}.png"
  end


  def generate_story
    suggested_words = Generator.fetch_possibilities(word: params[:word])

    response = {
      word: params[:word],
      suggestions: suggested_words
    }

    render json: response
  end

  private

  def generate_attributes
    path = Rails.root.to_s + "/db/text.json"
    attributes = load_attributes(path)
    template = attributes[:templates].sample
    background = attributes[:backgrounds].keys.sample

    character_params = {
      'name' => attributes[:names].sample,
      'trait' => attributes[:traits].sample,
      'race' => attributes[:races].sample,
      'job' => attributes[:jobs].sample,
      'location' => attributes[:locations].sample,
      'quirk' => attributes[:quirks].sample,
      'background' => background.to_s,
      'personality_traits' => attributes[:backgrounds][background]['personality_traits'].sample(2).join(' '),
      'ideal' => attributes[:backgrounds][background]['ideals'].sample,
      'bond' => attributes[:backgrounds][background]['bonds'].sample,
      'flaw' => attributes[:backgrounds][background]['flaws'].sample
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
      quirks: text["quirks"],
      backgrounds: text["backgrounds"]
    }
  end
end


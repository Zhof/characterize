class GenerationsController < ApplicationController
  def new
    @character_params = generate_attributes
    @character = Character.new(@character_params)
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


  def generate_story
    generator = CharacterGenerator.new(2)
    suggested_words = generator.fetch_possibilities(word: params[:word])

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

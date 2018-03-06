require 'json'

def load_attributes(file_name)
  file = File.read(file_name)
  text = JSON.parse(file)

  attributes = {
    templates: text["templates"],
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

  matches = {
    'trait' => attributes[:traits].sample,
    'race' => attributes[:races].sample,
    'job' => attributes[:jobs].sample,
    'location' => attributes[:locations].sample,
    'quirk' => attributes[:quirks].sample
   }

  template.gsub(/trait|race|job|location|quirk/) { |match| matches[match] }
end

generate

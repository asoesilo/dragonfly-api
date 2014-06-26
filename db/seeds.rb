# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'language_list'

language_index = 0
languages = LanguageList::COMMON_LANGUAGES.map do |language| 
  language_index += 1
  { id: language_index, name: language.name }
end


actions = [
  { id: 1, name: 'Teach' },
  { id: 2, name: 'Learn' }
]
genders = [
  { id: 1, description: 'Male' },
  { id: 2, description: 'Female' }
]

languages.each do |language|
  Language.create(id: language[:id], name: language[:name]) if Language.find_by(id: language[:id]).nil?
end

actions.each do |action|
  Action.create(id: action[:id], name: action[:name]) if Action.find_by(id: action[:id]).nil?
end

genders.each do |gender|
  Gender.create(id: gender[:id], description: gender[:description]) if Gender.find_by(id: gender[:id]).nil?
end
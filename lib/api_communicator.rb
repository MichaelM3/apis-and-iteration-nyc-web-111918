require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  found_character = nil
  page = 'http://www.swapi.co/api/people/'

  until found_character != nil || page.nil?
    response_hash = online_api_pull(page)
    page = response_hash["next"]
    found_character = response_hash["results"].find do |character|
      character["name"].downcase == character_name
    end
  end
 found_character
end

def print_movies(character)
  if character.nil?
    puts "Check another galaxy far far away."
  else
    page = "http://www.swapi.co/api/films/"
    response_hash = online_api_pull(page)
    character["films"].map do |film|
      puts response_hash["results"].find {|f| f["url"] == film}['title']
    end
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

def online_api_pull(page)
  response_string = RestClient.get(page)
  response_hash = JSON.parse(response_string)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

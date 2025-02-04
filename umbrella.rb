# Write your soltuion here!
require "http"
require "json"
require "dotenv/load"






### GOOGLE MAPS HANDLING SECTION

# User Input
puts "Where you at rn"
address = gets.chomp

# Hidden variable
google_api_key=ENV.fetch("GOOGLE_API_KEY")

# URL
google_maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{google_api_key}"


# Do the thing
raw_response = HTTP.get(google_maps_url)

parsed_response = JSON.parse(raw_response)

results_hash = parsed_response.fetch("results")
zero_hash = results_hash[0]
nav_hash = zero_hash.fetch("navigation_points")
location_hash = nav_hash[0].fetch("location")

long = location_hash.fetch("longitude").to_s
lat = location_hash.fetch("latitude").to_s

longlat = "/#{long}, #{lat}"
### PIRATE WEATHER HANDLING SECTION

# Hidden variables
pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_API_KEY")

# URL
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + longlat

# Do the thing
raw_response = HTTP.get(pirate_weather_url)


parsed_response = JSON.parse(raw_response)

# Get temp right now
currently_hash = parsed_response.fetch("currently")
current_temp = currently_hash.fetch("temperature").to_s
temp_string = "At " + address + ", it is currently " + current_temp 
curr_weth = currently_hash.fetch("icon")
if curr_weth == "clear-day" || curr_weth == "clear-night"
  weth_string = " with clear skies"
elsif curr_weth == "rain"
  weth_string = " and raining"
elsif curr_weth == "snow"
  weth_string = " and snowy"
elsif curr_weth == "sleet"
  weth_string = " but be careful, it's sleeting"
elsif curr_weth == "wind"
  weth_string = " with some blusters"
elsif curr_weth == "fog"
  weth_string = " with some fog"
elsif curr_weth == "cloudy" || curr_weth == "partly-cloudy-day" || curr_weth == "partly-cloudy-night"
  weth_string = " with some clouds"
else
  weth_string = " but unfortunately our satelites are blocked... look out your window!"
end

puts temp_string + weth_string

# # Get next hour temp
# hourly_hash = parsed_response.fetch("hourly")
# data_hash = hourly_hashed.fetch("data")

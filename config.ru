require 'sinatra'
require 'pry-byebug'
require 'json'
require 'httparty'

post '/' do

    content_type :json

    text = params.fetch('text').strip
    user = params.fetch('user_name')

    response        = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{text}/")
    pokemon_name    = response["name"]

    if pokemon_name

        pokemon_image   = response["sprites"]["front_default"]

        {
            "channel"       => params.fetch("channel_id"),
            "response_type" => "in_channel",
            "username"      => user,
            "text"          => "<!channel> \n#{user} just spotted a *#{text}*",
            "attachments"   => [
                {
                    "color"     => "#36a64f",
                    "title"     => "#{pokemon_name}",
                    "image_url" => "#{pokemon_image}"
                }
            ]
        }.to_json
    else
        {
            "text"          => "What is this *#{text}* you speak of? I don't recognise it.",
        }.to_json
    end

end

run Sinatra::Application

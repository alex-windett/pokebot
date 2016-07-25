require 'sinatra'
require 'pry-byebug'
require 'json'
require 'httparty'

post '/' do

# binding.pry

    content_type :json

    text = params.fetch('text').strip
    user = params.fetch('user_name')

    response        = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{text}/")

    pokemon_name    = response.name
    pokemon_iamge   = response.sprites.front_default

    {
        "channel"       => params.fetch("channel_id"),
        "response_type" => "in_channel",
        "username"      => user,
        "text"          => "<!channel> \n#{user} just spotted a *#{text}*",
        "attachments"   => {
            "color"     => "#36a64f",
            "title"     => "#{pokemon_name}",
            "image_url" => "#{pokemon_iamge}"
        }
    }.to_json

end

run Sinatra::Application

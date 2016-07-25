require 'sinatra'
require 'pry-byebug'
require 'json'

post '/' do

    # text = params.fetch('text').strip
    # user = params.fetch('user_name')

# binding.pry
    # body = {
    #   "channel" => params.fetch('channel_id'),
    #   "username" => arams.fetch('user_name'),
    #   "text" => params.fetch('text').strip
    # }

    content_type :json
    text = params.fetch('text').strip
    user = params.fetch('user_name')
    {
        "channel"       => params.fetch("channel_id"),
        "response_type" => "in_channel",
        "username"      => user,
        "text"          => "<!channel> #{user} just spotted a #{text}"
    }.to_json
end

run Sinatra::Application

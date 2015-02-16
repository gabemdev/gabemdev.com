require 'sinatra/content_for'
require 'json'

# Connect to Redis
uri = URI.parse(ENV['REDISTOGO_URL'] || 'redis://localhost:6379')
$redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

module GabemdevCom
    module NumberHelpers
    def format_number(number)
      number.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
    end
end

  class Application < Sinatra::Base
    helpers Sinatra::ContentFor
    helpers GabemdevCom::NumberHelpers

    # Homepage
    get '/' do
        erb :index
    end

    # Redirect blog
    get '/blog' do
      redirect 'http://blog.gabemdev.com'
    end

   # Static Pages
    %w{about blog work}.each do |page|
      get "/#{page}" do
        erb page.to_sym
      end
    end

    # Redirect resume to GitHub
    get /resume|cv/ do
      redirect 'https://github.com/gabemdev/resume/blob/master/Gabe%20Morales%20Resume.pdf?raw=true'
    end

    # Redirect posts to blog
    get %r{/([\w\d\-]+)$} do |key|
      # TODO: Maybe hit an API occasionally to get allowed keys
      # and then 404 if it's not a blog post I've written.
      redirect "http://blog.soff.es/#{key}"
    end

  end
end



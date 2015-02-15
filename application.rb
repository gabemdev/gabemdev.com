require 'sinatra/content_for'
require 'json'


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

  end
end



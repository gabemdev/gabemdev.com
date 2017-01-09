require 'rubygems'
require 'bundler'
Bundler.require

# require 'base64'
require 'httparty'
require 'json'
require 'octokit'
require 'open-uri'
require 'nori'

desc 'Update all of the things'
task :update => [:'update:blog']

namespace :update do
  desc 'Store my latest post in Redis'
  task :blog do
    response = HTTParty.get('https://medium.com/@gabemdev/latest')
    post = JSON(response.body).first

    %w{title excerpt_html url}.each do |key|
      redis.hset 'latest_post', key, post[key]
    end

    puts "Done! Cached `#{post['title']}`"
  end

def redis
  @redis ||= if ENV['REDISTOGO_URL']
    uri = URI.parse(ENV['REDISTOGO_URL'])
    Redis.new(host: uri.host, port: uri.port, password: uri.password)
  else
    Redis.new
  end
end

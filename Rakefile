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

private

def redis
  @_redis ||= begin
    uri = URI.parse(ENV['REDIS_URL'] || 'redis://localhost:6379')
    Redis.new(host: uri.host, port: uri.port, password: uri.password)
  end
end

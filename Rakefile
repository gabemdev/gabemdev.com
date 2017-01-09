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
    # response = HTTParty.get('https://medium.com/@gabemdev/latest')
    doc = Nori.new.parse(open('https://medium.com/@gabemdev/latest').read)
    post = doc['rss']['channel']['item'].first

    redis.hset 'latest_post', 'title', post['title']
    redis.hset 'latest_post', 'excerpt_html', post['description']
    redis.hset 'latest_post', 'url', post['link']

    puts "Done! Cached `#{post['title']}`"
  end
end

private

def redis
  @_redis ||= begin
    uri = URI.parse(ENV['REDIS_URL'] || 'redis://localhost:6379')
    Redis.new(host: uri.host, port: uri.port, password: uri.password)
  end
end

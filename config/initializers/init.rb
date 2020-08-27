require 'dotenv/load'
require 'roda'
require "json"
require 'sidekiq'
require 'sidekiq/web'
require 'erubi'
require "sinatra/activerecord"
require_relative "roda_ext"

def dirload(dir)
  File.join(__dir__, "../../#{dir}/*.rb")
end

Dir.glob([
  dirload("controllers"),
  dirload("models"),
  dirload("jobs")
]).each { |file| require file }

require 'dotenv/load'
require 'roda'
require 'json'
require 'securerandom'
require 'argon2'
require 'sidekiq'
require 'sidekiq/web'
require 'erubi'
require 'active_record'
require_relative 'ar_ext'

def dirload(dir)
  File.join(__dir__, "../../#{dir}/*.rb")
end

def all_directories
  %w(
    controllers/base controllers
    models jobs/base jobs
  ).map { |dir| dirload(dir) }
end

Dir.glob(all_directories).each { |file| require file }

ActiveRecordRoda.register!

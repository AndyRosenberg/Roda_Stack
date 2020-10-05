require_relative 'mail_config'
require_relative 'sidekiq_config'

class MailWorker
  include Sidekiq::Worker

  def self.perform_async_in_prod(*args)
    ENV["RACK_ENV"] == 'production' ? perform_async(*args) : new.perform(*args)
  end
end
require_relative 'config/mail_config'
require_relative 'config/sidekiq_config'

class MailWorker
  include Sidekiq::Worker
end
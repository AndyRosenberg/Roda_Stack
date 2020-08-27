require 'mail'

options = { :address              => ENV["SMTP_ADDRESS"],
            :port                 => ENV["SMTP_PORT"],
            :domain               => ENV["SMTP_HOST"],
            :user_name            => ENV["SMTP_USER"],
            :password             => ENV["SMTP_PASSWORD"],
            :authentication       => 'plain',
            :enable_starttls_auto => true  }



Mail.defaults do
  delivery_method :smtp, options
end

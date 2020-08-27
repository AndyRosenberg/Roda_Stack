require_relative 'mail_job'

class WelcomeMailer < MailWorker
  def perform(user)
    message = <<~MSG
      <h3>Thanks for signing up for #{ENV['APP_NAME']}!</h3>
      <p>Feel free to explore and update your dynamic posts.</p>
    MSG

    Mail.deliver do
      to      user['email']
      from    "#{ENV['APP_NAME']} <admin@po-it.com>"
      subject "Welcome to #{ENV['APP_NAME']}"

      html_part do
        content_type 'text/html; charset=UTF-8'
        body message
      end
    end
  end
end
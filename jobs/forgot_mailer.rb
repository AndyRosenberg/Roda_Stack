require_relative 'mail_job'

class ForgotMailer < MailWorker
  def perform(user_id)
    user = User.find(user_id)

    message = <<~MSG
      <h3>Follow the link below to reset your password.</h3>
      <p><a href=#{ENV['ROOT_URL']}/logins/reset/#{user.reset_token}>Click here to reset</a></p>
      <p><small>This link will expire one hour after this email has been sent.</small></p>
    MSG

    Mail.deliver do
      to      user.email
      from    "#{ENV['APP_NAME']} <admin@po-it.com>"
      subject "Reset Your Password on #{ENV['APP_NAME']}"

      html_part do
        content_type 'text/html; charset=UTF-8'
        body message
      end
    end
  end
end
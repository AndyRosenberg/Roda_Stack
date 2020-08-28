class LoginsController < Roda
  route do |r|
    r.get "sign_in" do
      view('logins/sign_in')
    end

    r.post "authenticate" do
      params = login_params(r)
      user = User.find_by(
        "LOWER(?) IN (LOWER(name), LOWER(email))",
        params["email"]
      )

      if user && user.authenticate(params["password"])
        session["current_user_id"] = user.id
        flash["message"] = "Login successful!"
        r.redirect("/")
      else
        flash.now["message"] = "Invalid username or password."
        view('logins/sign_in')
      end
    end

    r.get "sign_out" do
      session.clear
      flash["message"] = "Signed Out Successfully!"
      r.redirect('/logins/sign_in')
    end

    r.on "forgot" do
      r.get do
        view("logins/forgot")
      end

      r.post do
        self.forgotten_user = User.find_by("LOWER(email) = LOWER(?)", r.params["email"])

        if forgotten_user && forgotten_user.update(reset_token: SecureRandom.uuid, sent_time: Time.now)
          ForgotMailer.perform_async_in_prod(forgotten_user.id)
          r.redirect("/")
        else
          flash.now["message"] = forgotten_user ? "Could not send. Please try again." : "User not found with that email."
          view("logins/forgot")
        end
      end
    end

    r.on "reset" do
      r.on String do |token|
        self.reset_token = token
        set_forgotten_user
        reset_redirects?

        r.get do
          view("logins/reset")
        end

        r.post do
          if reset_password(r)
            flash["message"] = "Password successfully updated!"
            r.redirect("/logins/sign_in")
          else
            flash_ar_errors(forgotten_user)
            view("logins/reset")
          end
        end
      end
    end
  end

  private
  attr_accessor :reset_token, :forgotten_user

  def login_params(r)
    r.params.slice("email", "password")
  end

  def set_forgotten_user
    self.forgotten_user = User.find_by_reset_token(reset_token) if reset_token.present?
  end

  def reset_redirects?
    if !forgotten_user || !forgotten_user.sent_time
      flash["message"] = "Unauthorized"
      r.redirect("/")
    elsif forgotten_user.sent_time < 1.hour.ago
      flash["message"] = "Token has expired."
      r.redirect("/logins/forgot")
    end
  end

  def reset_password(r)
    forgotten_user.update(
      password: r.params["password"],
      password_has_changed: true,
      reset_token: nil,
      sent_time: nil
    )
  end
end
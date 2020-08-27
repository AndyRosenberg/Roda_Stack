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
      flash.now["message"] = "Signed Out Successfully!"
      view('logins/sign_in')
    end

    r.get "forgot" do
      # forgot
    end
  end

  def login_params(r)
    r.params.slice("email", "password")
  end
end
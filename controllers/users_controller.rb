class UsersController < Roda
  route do |r|
    r.is do
      r.post do
        user = User.create(user_params(r))
        if !user.new_record?
          WelcomeMailer.perform_async(user.as_json)
          session["current_user_id"] = user.id
          flash["message"] = "User has been created!"
          r.redirect("/")
        else
          flash.now["message"] = "Something went wrong. Please try again."
          view('users/new')
        end
      end
    end

    r.get "new" do
      view('users/new')
    end

    r.on Integer do |id|
      r.is do
        r.get do
          # show
        end

        r.put do
          authorize_user(r, id)
          new_attrs = user_params(r)

          if new_attrs["password"].empty?
            new_attrs.delete("password")
          else
            user.password_has_changed = true
          end

          if user.update(new_attrs)
            flash["message"] = "User has been updated!"
            r.redirect("/")
          else
            somethings_wrong("Something went wrong. Please try again.")
          end
        end

        r.delete do
          authorize_user(r, id)
          if r.params["confirm"] == user.name
            if user.destroy
              flash["message"] = "User has been deleted!"
              session.clear
              r.redirect("/")
            else
              somethings_wrong("User has been deleted!")
            end
          else
            somethings_wrong("Name did not match.")
          end
        end
      end

      r.get "edit" do
        authorize_user(r, id)
        @current_user_json = user.to_json
        view('users/edit')
      end
    end
  end

  private
  attr_accessor :user, :current_user_id

  def user_params(r)
    r.params.slice("email", "name", "password", "time_zone")
  end

  def authorize_user(r, id)
    self.current_user_id = session["current_user_id"]

    unless current_user_id && id == current_user_id.to_i
      flash["message"] = "Unauthorized update this user."
      r.redirect("/")
    end

    self.user = User.find(current_user_id)
  end

  def somethings_wrong(message)
    flash.now["message"] = message
    @current_user_json = user.to_json
    view('users/edit')
  end
end

class UsersController < Roda
  route do |r|
    r.is do
      r.post do
        user = User.create(user_params(r))
        if !user.new_record?
          WelcomeMailer.perform_async_in_prod(user.id)
          session["current_user_id"] = user.id
          flash["message"] = "User has been created!"
          r.redirect("/")
        else
          flash_ar_errors(user)
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
            flash_ar_errors_with_edit_render
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
              flash_ar_errors_with_edit_render
            end
          else
            flash_ar_errors_with_edit_render
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
  attr_accessor :user

  def user_params(r)
    r.params.slice("email", "name", "password", "time_zone")
  end

  def authorize_user(r, id)
    self.user = User.find_by(id: session["current_user_id"]) if session["current_user_id"]

    unless user && id == user.id
      flash["message"] = "Unauthorized update this user."
      r.redirect("/")
    end
  end

  def flash_ar_errors_with_edit_render
    flash_ar_errors(user)
    @current_user_json = user.to_json
    view('users/edit')
  end
end

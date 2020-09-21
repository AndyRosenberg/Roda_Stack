require "./config/initializers/init.rb"

class App < Roda # :nodoc:
  controllers = %w(
    users logins
  )

  route do |r|
    r.public

    r.root { view("home") }

    r.on controllers do |controller|
      run_controller(r, controller)
    end
  end

  private

  def run_controller(r, controller)
    r.run(
      Object.const_get(
        controller.capitalize.concat("Controller")
      )
    )
  end
end

require "./config/initializers/init.rb"

class App < Roda # :nodoc:
  route do |r|
    r.public

    r.root do
      view("home")
    end

    r.on 'users' do
      r.run UsersController
    end

    r.on 'logins' do
      r.run LoginsController
    end
  end
end

require "./app"

run Rack::URLMap.new('/' => App.freeze, '/sidekiq' => Sidekiq::Web)

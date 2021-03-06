class BaseController < Roda
  use Rack::MethodOverride
  plugin :render, escape: true
  plugin :sessions, secret: ENV["SESSION_SECRET"]
  plugin :all_verbs
  plugin :route_csrf, require_request_specific_tokens: false
  plugin :public
  plugin :flash
  plugin :json_parser

  def api_only(r)
    unless r.env["HTTP_ACCEPT"].split(",").first == "application/json"
      r.redirect "/"
    end
  end

  def render_json(json)
    response.headers['Content-Type'] = 'application/json'
    response.write(json)
  end

  def render_unprocessable
    response.status = 422
    render_json({}.to_json)
  end
  
  %w(primary success info warning danger).each do |klass|
    define_method("flash_#{klass}") do |message, now: false|
      flash_with_class(message, klass, now)
    end
  end

  def flash_ar_errors(object)
    errors = object.errors.full_messages.join(", ")
    flash_danger(errors, now: true)
  end

  private

  def flash_with_class(message, klass, now = false)
    current_flash = now ? flash.now : flash
    current_flash["message"], current_flash["klass"] = message, klass
  end
end

module RodaFlash
  %w(primary success info warning danger).each do |klass|
    define_method("flash_#{klass}") do |message, now: false|
      flash_with_class(message, klass, now)
    end
  end

  def flash_with_class(message, klass, now = false)
    current_flash = now ? flash.now : flash
    current_flash["message"], current_flash["klass"] = message, klass
  end

  def flash_ar_errors(object)
    errors = object.errors.full_messages.join(", ")
    flash_danger(errors, now: true)
  end
end

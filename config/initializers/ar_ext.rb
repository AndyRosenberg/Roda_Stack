module ActiveRecordRoda
  def self.environment
    ENV["RACK_ENV"] || "development"
  end

  def self.register!
    if ENV['DATABASE_URL']
      self.database = ENV['DATABASE_URL']
    elsif File.exist?("#{Dir.pwd}/config/database.yml")
      self.database_file = "#{Dir.pwd}/config/database.yml"
    end

    unless defined?(Rake) || ENV["RACK_ENV"] == "production"
      ActiveRecord::Base.logger = Logger.new(STDOUT)
    end
  end

  def self.database_file=(path)
    path = File.join(root, path) if Pathname(path).relative? and root
    spec = YAML.load(ERB.new(File.read(path)).result) || {}
    self.database = spec
  end

  def self.database=(spec)
    if spec.is_a?(Hash) and spec.symbolize_keys[environment.to_sym]
      ActiveRecord::Base.configurations = spec.stringify_keys
      ActiveRecord::Base.establish_connection(environment.to_sym)
    elsif spec.is_a?(Hash)
      ActiveRecord::Base.configurations = {
        environment.to_s => spec.stringify_keys
      }

      ActiveRecord::Base.establish_connection(spec.stringify_keys)
    else
      if Gem.loaded_specs["activerecord"].version >= Gem::Version.create('6.0')
        ActiveRecord::Base.configurations ||= ActiveRecord::DatabaseConfigurations.new({}).resolve(spec)
      else
        ActiveRecord::Base.configurations ||= {}
        ActiveRecord::Base.configurations[environment.to_s] = ActiveRecord::ConnectionAdapters::ConnectionSpecification::ConnectionUrlResolver.new(spec).to_hash
      end

      ActiveRecord::Base.establish_connection(spec)
    end
  end
end
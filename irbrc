DataMapper::Logger.new(STDOUT)                 if defined?(DataMapper)
ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord)

require 'active_record'
require_relative '../config/database'

# Set the migrations path
ActiveRecord::Migrator.migrations_paths = ['db/migrate']

puts "Running migrations..."
ActiveRecord::MigrationContext.new(ActiveRecord::Migrator.migrations_paths.first, ActiveRecord::SchemaMigration).migrate
puts "Migrations applied successfully!"
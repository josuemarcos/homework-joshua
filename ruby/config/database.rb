require 'active_record'
require 'dotenv/load'

DB = ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => ENV['DB_NAME'],
  :host => ENV['DB_HOST'],
  :username => ENV['DB_USER'],
  :password => ENV['DB_PASS'],
  :port     => 5432
)

puts "Connected to database: #{ENV['DB_NAME']}"
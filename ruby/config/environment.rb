require 'sinatra/activerecord'
require 'sinatra'
require 'sinatra/base'
require 'dotenv'
require_relative '../app/routes/home'
require_relative '../app/routes/articles'
require_relative '../app/routes/health'
require_relative '../app/models/article'
require_relative '../app/middleware/auth'


Dotenv.load "#{__dir__}/.env"

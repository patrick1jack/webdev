require 'rubygems'
require 'sinatra'
require 'bundler/setup'
require 'json'
Bundler.require
require './models/TodoItem'

if ENV['DATABASE_URL']
   ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
   ActiveRecord::Base.establish_connection(
	:adapter => 'sqlite3',
	:database => 'db/development.db',
	:encoding => 'utf8'
)
end

get '/' do
@all_items = TodoItem.all
erb :sina
end

post '/' do
     
     TodoItem.create(description: params[:task], due: params[:date])
     task_data = params[:task]
     date_data = params[:date]
end
delete '/' do 
       TodoItem.find(task_data).destroy
       TodoItem.find(date_data).destroy 
redirect '/'
end





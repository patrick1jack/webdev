require 'rubygems'
require 'sinatra'
require 'bundler/setup'
require 'json'
Bundler.require
require './models/TodoItem'
ActiveRecord::Base.establish_connection(
	:adapter => 'sqlite3',
	:database => 'db/development.db',
	:encoding => 'utf8'
)
file = File.read('hw_list.txt')

lines = file.split("\n")


lines.each do |line|
task, date = line.split("-")

  puts" #{task}: #{date}"
end

get '/' do
@all_items = TodoItem.all
erb :sina
end

post '/' do
     
     TodoItem.create(description: params[:task], due: params[:date]) 
redirect '/'
end



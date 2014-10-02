require 'rubygems'
require 'sinatra'
#require 'bundler/setup'
require 'json'

file = File.read('hw_list.txt')

lines = file.split("\n")


lines.each do |line|
task, date = line.split("-")

  puts" #{task}: #{date}"
end

get '/form' do
file = File.read('hw_list.txt')
@lines = file.split("\n")
erb :sina
end

post '/form' do
  
     File.open("hw_list.txt", "a") do |file|
     file.puts "#{params[:task]} - #{params[:date]}"
     
end
redirect '/form'
end



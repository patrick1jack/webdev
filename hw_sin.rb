require 'rubygems'
require 'sinatra'
require 'bundler/setup'
require 'json'
Bundler.require
require './models/TodoItem'
require './models/User'

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
    @users = User.all.order(:name)
    erb :user_list
end

get '/:user' do
    @user = UserId.find(parms[:user])
    @all_items = @user.TodoItem.order(:due)
    erb :sina
end

post '/new_user' do
     @user = User.create(params)
     redirect '/'
end

post '/delete_user/:id' do
    User.find(params[:id]).destroy
    redirect '/'
end

post '/:user/new_item' do
     User.find(params[:user]).todoitems.create(description: params[:task], due: params[:date])
     redirect '/#{params[:user]}'
end

post '/delete_item/:id' do 
       @todo_item = TodoItem.find(params[:id])
       @user = @todo_item.user
       @todo_item.destroy   
       redirect '/#{@user.id}'
end





require 'bundler'
Bundler.require

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/main.db')
require './models.rb'

use Rack::Session::Cookie, :key => 'rack.session',
    :expire_after => 2592000,
    :secret => SecureRandom.hex(64)

get '/leave' do
  session.clear

  redirect '/'
end

get '/' do
  erb :opening
end

get '/:id/home' do
  @user = User[params[:id]]
  @users = User.all
  @threads = Discussion.all
  erb :home
end

get '/new_user' do
  erb :create_user
end

post '/:id/new_thread' do
  @user = User[params[:id]]
  p = Discussion.new
  p.title = params[:topic]
  p.save
  @user.add_discussion(p)

  redirect "/#{@user.id}/home"
end

post '/login' do
  username = params[:username]
  password = params[:password]
  @user = User.first(:username => username)
  if @user != nil
    if password == @user.password
      redirect "/#{@user.id}/home"
      session[:visited] = true
    else
      @error_message = "Username or password is incorrect"
      redirect '/'
    end
  else
    @error_message = "Please enter your username and password"
    redirect '/'
  end
end

post '/user/create' do
  password = params[:password]
  password_check = params[:password_check]
  username = params[:username]
  if password == password_check
    u = User.new
    u.name = params[:name]
    u.username = params[:username]
    u.password = params[:password]
    u.save
    redirect '/'
  else
    redirect '/create_user'
  end
end

get '/:id/thread' do
  @thread = Discussion[params[:id]]
  @posts = @thread.contents

  erb :thread
end

post '/:id/new_post' do
  @discussion = Discussion[params[:id]]
  c = Content.new
  c.title = params[:title]
  c.body = params[:body]
  c.save
  @discussion.add_content(c)

  redirect "/#{@discussion.id}/thread"
end

get '/:id/post' do
  @post = Content[params[:id]]
  @comments = @post.comments

  erb :post
end

post '/:id/new_comment' do
  @post = Content[params[:id]]
  c = Comment.new
  c.text = params[:text]
  c.save
  @post.add_comment(c)

  redirect "/#{@post.id}/thread"
end


#creating comments
#@content = Content.first(:id => ...)
#c = Comment.new
#c.text = ...
#c.content = @content
#c.save
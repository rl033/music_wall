# Homepage (Root path)
helpers do
  def user_signed_in?
    session[:user_id] && session[:user_id] != ""
  end

  def get_current_user
    User.find_by_id(session[:user_id]) if user_signed_in?
  end
end

get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  @tracks = Track.includes(:user)
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks/new' do
  id = session[:user_id] if user_signed_in?
  @track = Track.new(
    title: params[:title],
    author: params[:author],
    url: params[:url],
    user_id: id
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end


get '/tracks/:id' do
  @track = Track.find params[:id]
  erb :'tracks/show'
end

get '/users/signup' do
  @user = User.new
  erb :'users/signup'
end

post '/users/signup' do
  @user = User.new(
    name: params[:name],
    password: params[:password]
  )
  if @user.save
    redirect '/tracks'
  else
    erb :'users/signup'
  end
end

get '/users/signin' do
  erb :'users/signin'
end

post '/users/signin' do
  @user = User.find_by_name(params[:name])
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/tracks'
  else
    redirect '/users/signin'
  end
  
end

get '/users/signout' do
  session[:user_id] = ""
  redirect '/tracks'
end
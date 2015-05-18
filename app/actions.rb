# Homepage (Root path)
get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks/new' do
  @track = Track.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
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
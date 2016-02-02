require_relative 'order_actions'

##################
###PAGE METHODS###
##################

def taglines
  @taglines = ["For those special times when you just don't give a !@\#$.","Serving up a hot slice of random.","Why choose when you could not?","Here, let me get that for you.","Go ahead—bring a stranger some food.","Bringing you what you didn't know you wanted.","Officially endorsed by David Van Dusen."]
  @taglines.sample
end

helpers do
  
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def cuisine_options_filter(selected_cuisine)
    options = ['African', 'Burger', 'Greek', 'Mexican', 'Pizza', 'Seafood', 'Sushi', 'Thai']
    options.delete_if{|option| option == selected_cuisine}
  end

end

##############
####GETS######
##############
get '/' do
  if session[:message]
    @tagline = session[:message]
    session.delete(:message)
  else
    @tagline = taglines
  end
  erb :index
end

get '/user' do
  @user = User.all
  @order_history = Order.orderer_history(current_user.id)
  @deliver_history = Order.deliverer_history(current_user.id)
  @pending_orders = Order.user_pending_orders(current_user.id)
  @being_delivered = Order.being_delivered_orders(current_user.id)
  @pending_deliveries = Order.pending_deliveries(current_user.id)
  erb :user
end

get '/session/new' do
  erb :'session/new'
end

get '/session/signout' do
  session.clear
  redirect '/'
end

##############
####POSTS#####
##############

post '/session' do
  user = User.find_by(username: params[:username], password: params[:password])
  if user
    session[:user_id] = user.id
    redirect "/"
  else
    erb :'session/new'
  end
end
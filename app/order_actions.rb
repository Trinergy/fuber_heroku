##################
####ORDER GETS####
##################

get '/orders/menu' do 

  erb :'orders/menu'
end

get '/orders/new' do
  if current_user.nil?
    session[:message] = "Sign the *redacted* up, *redacted*"
    redirect '/'
  else
    @selected_cuisine = params[:cuisine]
    @cuisine_options = cuisine_options_filter(@selected_cuisine)
    erb :'orders/new'
  end
end

get '/orders' do 
  @user = User.all
  @pending_orders = Order.not_user_pending_orders(current_user.id) if current_user
  erb :'orders/index'
end

get '/orders/:order_id' do 
  @user = User.all
  @order = Order.find(params[:order_id])
  erb :'orders/show'
end

get '/orders/:order_id/deliver' do
  Order.process_delivery(params[:order_id], current_user.id)
  redirect '/orders'
end


####################
####ORDER POSTS#####
####################

post '/orders' do
  Order.new(cuisine: params[:cuisine], 
            price: params[:price], 
            delivery_date: params[:date], 
            delivery_time: params[:date] + ' ' + params[:time] + ':00', 
            destination: params[:destination], 
            comment: params[:comments],
            orderer_id: current_user.id,
            delivery_status: 1
            ).save
  redirect '/user'
end

post '/orders/:order_id/rate' do
  @user = User.all
  @order = Order.find(params[:order_id])
  @order.rating = params[:rating]
  @order.save
  @user = User.find(@order.deliverer_id)
  @user.rating = Order.where('deliverer_id = ?', @order.deliverer_id).average(:rating).to_f
  @user.save
  redirect :user
end
class SessionsController < ApplicationController
  def index
  end

  def new
    #TODO: dynamicize URL based on environment
    callback_url = "http://127.0.0.1:3000/sessions/callback"
    request_token = consumer.get_request_token(:oauth_callback => callback_url)
    #use cache instead of a session
    Rails.cache.write(request_token.token, request_token.secret)
    redirect_to request_token.authorize_url
  end

  def create
  end

  def destroy
  end

  def callback
    request_token = OAuth::RequestToken.new(consumer, params[:oauth_token], Rails.cache.read(params[:oauth_token]))
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    session[:access_token] = access_token.token
    session[:access_token_secret] = access_token.secret
    #GET THE USER HERE
    #TODO: get the actual production url here
    user = access_token.post "http://idr-wylie.office.infosiftr.com/oauth/get_user"
    result = JSON.parse(user.response.body)
    puts result['user']['uniqueId']
    #make the parms for update or create
    parms = {}
    result['user'].each do|key,val|
      if key != "id"
        if key == "type"
          parms['kind'] = val
        else
          parms[key] = val
        end
      end
    end
    #create or update the user
    usercheck = User.check(result['user']['uniqueId'])
    if !usercheck.empty?
      puts "USERCHECK"
      puts usercheck
      #update the existing user
    else
      puts "NO ONE HERE BY THAT NAME"
      #create the new user
      user = User.new(parms)
      user.save
    end
    #establish current_user helper
    #send the authenticated user on to the app
    puts "USER"
    puts user
    render :text => "MADE IT BACK"
  end




  private

  def consumer
    @consumer = User.consumer
  end

end

class WelcomeController < ApplicationController
  def index
    puts User.consumer
  end
end

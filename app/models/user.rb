class User < ActiveRecord::Base
  
  attr_accessible :type, :firstName, :lastName, :email, :username, :phone, :mobilePhone, :uniqueId, :phoneSecondary

  scope :check,    lambda{|unique| where("uniqueId = ?", unique)}

  def self.consumer_key
    return {
      :key => "8e6c12b0c996b057dd6570fa7a3d3f6d21766166", 
      :secret => "28cb6270785478783d164323b0b217078867cf3d0fc0308a7c3ccf8761ff7b2d"
    }
  end

  def self.consumer_options
    return {
      :site => 'http://idr-wylie.office.infosiftr.com',
      :scheme => :body 
    }
  end

  def self.consumer
    @consumer ||= OAuth::Consumer.new( self.consumer_key[:key], self.consumer_key[:secret], self.consumer_options)
  end

end

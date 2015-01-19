#require dependencies
require 'rubygems'
require 'openssl'
require 'oauth'
require 'json'

class AccessController < ApplicationController
  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout, :blog, :contact, :faqs]

  def index
    @user = User.find(session[:user_id])
  end

  def login
  end

  def contact
  end

  def faqs
  end

  def attempt_login
    if params[:name].present? && params[:password].present?
      authorized_user = User.authenticate(params[:name], params[:password])
      # redirect_to schedule_url(:id => authorized_user.id)#will need to each specific user
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:name] = authorized_user.name
      flash[:notice] = "You are now logged in"
      redirect_to(:action => "index")
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
   session[:user_id] = nil
   session[:name] = nil
   flash[:notice] = "Logged out"
   redirect_to(:action => "login")
 end

#<------------------------------------------------------------->
# Twitter api add


def blog

  #build access tokens and apikey
  consumer_key = OAuth::Consumer.new("fnCjxeY7S1z42zznv9Bvyg",
    "wKF4RZ5JPRIvzZ337T6aG1HZfVi0jiFUDqUyqnhQQ")
  access_token = OAuth::Token.new(
    "62972312-EvOQD1f0Puqn7xikzwpa6xMgt7yiWU0OILT1TuZxB",
    "NMM2rkAuDTz6U5g0iDCPEB0UUuhuQlRl30mAFdkerIAWH")

  address, request = build_req_string

  # Set up HTTP.
  http             = Net::HTTP.new address.host, address.port
  http.use_ssl     = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Issue the request.
  request.oauth! http, consumer_key, access_token
  http.start
  response = http.request request

  # Parse and print the Tweet if the response code was 200
  @tweets = JSON.parse(response.body)

  # @tweets.first.second.each do |t|
  #     # @tweet = t['user']
  #      @tweet = t
  # end

end

def build_req_string
  baseurl = "https://api.twitter.com"
  path    = "/1.1/search/tweets.json"
  query   = URI.encode_www_form(
    "q" => "%23studybuddy",
    "result_type" => "recent",
    "until" => "2014-11-04",
    "count" => 20
    )
  address = URI("#{baseurl}#{path}?#{query}")
  request = Net::HTTP::Get.new address.request_uri
  return address, request
end




end

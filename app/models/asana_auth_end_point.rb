class AsanaAuthEndPoint < ActiveRecord::Base
  belongs_to :user

  require "uri"
  require "net/http"

  def access
  	if self.refresh_token != nil and self.refresh_token != ""#check to see if you have a refresh token
  		if self.token_date < 1.hours.ago #if you do check to see if it hase expired
  			self.request_token_with_refresh_token
  		end
  	else #if you don't requrest one with a code
  		self.request_token_with_code
  	end
  	return self
  end

  def request_token_with_refresh_token
  	params = {'grant_type' => 'refresh_token',
					'client_id' => '79018136406691',
					'client_secret' => '07191864d5950231a706ece685eb1859',
					'redirect_uri' => 'http://localhost:3000/asana_auth_end_points/new',
					'refresh_token' => self.refresh_token}
	x = Net::HTTP.post_form(URI.parse('https://app.asana.com/-/oauth_token'), params)
	puts data = JSON.parse(x.body)
	@now = DateTime.now
	self.update(:bearer_token => data["access_token"], :refresh_token => data["refresh_token"], :token_date => @now)
  end

  def request_token_with_code
	params = {'grant_type' => 'authorization_code',
					'client_id' => '79018136406691',
					'client_secret' => '07191864d5950231a706ece685eb1859',
					'redirect_uri' => 'http://localhost:3000/asana_auth_end_points/new',
					'code' => self.auth_code}
	#puts params
	x = Net::HTTP.post_form(URI.parse('https://app.asana.com/-/oauth_token'), params)
	data = JSON.parse(x.body)
	#puts data["access_token"]
	#puts data["refresh_token"]
	@now = DateTime.now
	self.update(:bearer_token => data["access_token"], :refresh_token => data["refresh_token"], :token_date => @now)
  end
end

class AsanaTask < ActiveRecord::Base

	require 'net/http'
	require 'curb'

  def display
  	if self.name == "" or self.name == nil
  		return self.url
  	else
  		return self.name
  	end
  end

  def derived_id
  	return self.url.split(/\//).last
  end

  def get_task_data_from_asana
	client = Asana::Client.new do |c|
	 c.authentication :oauth2, bearer_token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRob3JpemF0aW9uIjo3OTAxODcwOTM0Njk1MCwic2NvcGUiOiIiLCJpYXQiOjE0NTI3NTYxNTksImV4cCI6MTQ1Mjc1OTc1OX0.MqJfIEvBobb2yojqRtmTB0PCqu-3KRslH0kBDGXofLA'
	end
	return client.tasks.find_by_id(self.derived_id)
  end

end

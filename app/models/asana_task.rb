class AsanaTask < ActiveRecord::Base
  belongs_to :asana_workspace, class_name: "AsanaWorkspace", foreign_key: "asana_workspace_id"

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

  def get_active_asana_client
    asana_endpoint = self.asana_workspace.asana_auth_endpoint.access

    client = Asana::Client.new do |c|
      c.authentication :oauth2, bearer_token: asana_endpoint.bearer_token
    end
    return client
  end

  def get_task_data_from_asana
    client = self.get_active_asana_client
  	return client.tasks.find_by_id(self.derived_id)
  end

end

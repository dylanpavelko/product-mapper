class User < ActiveRecord::Base
	attr_accessor :password
	require 'bcrypt'

	EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :confirmation => true #password_confirmation attr
	validates_length_of :password, :in => 6..20


	before_save :encrypt_password
	after_save :clear_password

	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
	  end
	end

	def clear_password
	  self.password = nil
	end

	def self.authenticate(username_or_email="", login_password="")
	  if  EMAIL_REGEX.match(username_or_email)    
	    user = User.find_by_email(username_or_email)
	  else
	    user = User.find_by_username(username_or_email)
	  end
	  if user && user.match_password(login_password)
	    return user
	  else
	    return false
	  end
	end   

	def match_password(login_password="")
	  encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
	end


	def picture
		@pictures = ProfileImage.where(:user_id => self.id)
		if @pictures.count > 0
			return @pictures.first.image.url
		else

			# get the email from URL-parameters or what have you and make lowercase
			email_address = self.email.downcase
	 
			# create the md5 hash
			hash = Digest::MD5.hexdigest(email_address)
	 
			# compile URL which can be used in <img src="RIGHT_HERE"...
			image_src = "https://www.gravatar.com/avatar/#{hash}"

			return image_src
		end
	end

	def display_name
		return self. first_name + " " + self.last_name
	end

	def can_groom_backlog
		@has_roles = UserHasRoleForNode.where(:user_id => self.id)
		@has_roles.each do |has_role|
			if has_role.role.prioritize
				return true
			end
		end
		return false
	end

	def can_groom_backlog_for_node(node)
		@has_roles = UserHasRoleForNode.where(:user_id => self.id)

		@ancestry_nodes = Array.new
	    @i = node
	    while @i.parent != nil do 
	      @ancestry_nodes << @i.parent
	      @i = @i.parent
	    end
	    @ancestry_nodes << node 

		@ancestry_nodes.each do |node|
			#for each node check to see if they have a role that gives them edit access
			@has_node_roles = @has_roles.where(:node_id => node.id)
				@has_node_roles.each do |has_role|
					if has_role.role.prioritize or (has_role.lead and has_role.role.edit_nodes)
						return true
					end
				end
			end
		return false
	end

	def can_view_nodes
		@has_roles = UserHasRoleForNode.where(:user_id => self.id)
		@has_roles.each do |has_role|
			if has_role.role.view_product
				return true
			end
		end
		return false
	end

	def can_manage_phases
		@has_roles = UserHasRoleForNode.where(:user_id => self.id)
		@has_roles.each do |has_role|
			if has_role.role.manage_phases
				return true
			end
		end
		return false
	end

	def can_manage_product
		@has_roles = UserHasRoleForNode.where(:user_id => self.id)
		@has_roles.each do |has_role|
			if has_role.role.edit_nodes
				return true
			end
		end
		return false
	end

	def can_manage_product_for_node(node)
		@has_roles = UserHasRoleForNode.where(:user_id => self.id)

		@ancestry_nodes = Array.new
	    @i = node
	    while @i.parent != nil do 
	      @ancestry_nodes << @i.parent
	      @i = @i.parent
	    end
	    @ancestry_nodes << node 

		@ancestry_nodes.each do |node|
			#for each node check to see if they have a role that gives them edit access
			@has_node_roles = @has_roles.where(:node_id => node.id)
				@has_node_roles.each do |has_role|
					if has_role.role.edit_nodes
						return true
					end
				end
			end
		return false
	end

	def can_manage_people
		@has_roles = UserHasRoleForNode.where(:user_id => self.id)
		@has_roles.each do |has_role|
			if has_role.role.manage_people
				return true
			end
		end
		return false
	end

end

class Response < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :user
end

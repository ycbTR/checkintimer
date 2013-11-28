class Authentication < ActiveRecord::Base
  attr_accessible :oauth_secret, :oauth_token, :profile_picture_url, :provider, :uid, :user_id
end

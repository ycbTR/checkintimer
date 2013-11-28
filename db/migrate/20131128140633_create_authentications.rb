class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :uid
      t.string :oauth_token
      t.string :oauth_secret
      t.integer :user_id
      t.string :provider
      t.string :profile_picture_url

      t.timestamps
    end
  end
end

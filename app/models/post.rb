class Post < ActiveRecord::Base
  attr_accessible :media_type, :provider, :title, :url, :views, :total, 
  :increases, :user_id, :embed_code, :provider_url, :thumbnail_url, :description, :author_name, :tweets

 validates_presence_of :url

 belongs_to :user

end

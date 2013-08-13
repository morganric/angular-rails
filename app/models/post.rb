class Post < ActiveRecord::Base
  attr_accessible :media_type, :provider, :title, :url, :views, :total, :increases

 validates_presence_of :url

end

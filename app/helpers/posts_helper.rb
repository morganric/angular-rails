module PostsHelper

  def tweet
  puts "I am here!"
  print "I am here!"
  @post = Post.find(params[:id])

  new_tweets = @post.tweets.to_i + 1
  new_views = @post.views.to_i + 100
  @post.update_attributes({:views => new_views, :tweets => new_tweets })
  @post.save

  respond_to do |format|
      if @post.update_attributes({:views => new_views, :tweets => new_tweets })
  #         # format.html { render :partial => 'data', :content_type => 'text/html', notice: "#{num} Views were added." }
  #          # format.js { render :partial => 'data', :content_type => 'text/javascript', notice: "#{num} Views were added." }
          format.json { head :no_content }
           format.js 
  #          format.html { redirect_to :back, :remote => true }
      else
  #       # format.html { render :partial => 'data', :content_type => 'text/html', status: :unprocessable_entity }
        format.json { head :no_content }
         format.js { redirect_to @post, notice: "No views were added."}
  #        format.html { redirect_to :back, :remote => true } 
      end
    end
  end

 def data
    @post = Post.find(params[:id])
    @views = @post.views
    num = params[:num]
    @newviews = @views + num.to_i  
    @post.update_attributes({:views => @newviews })
    @post.increases = @post.increases + 1


    respond_to do |format|
      if @post.save
          # format.html { render :partial => 'data', :content_type => 'text/html', notice: "#{num} Views were added." }
           # format.js { render :partial => 'data', :content_type => 'text/javascript', notice: "#{num} Views were added." }
           format.js 
           format.html { redirect_to :back, :remote => true }
      else
        # format.html { render :partial => 'data', :content_type => 'text/html', status: :unprocessable_entity }
         format.js { redirect_to @post, notice: "No views were added."}
         format.html { redirect_to :back, :remote => true } 
      end
    end
  end

  private

  def embedly_title(post)
	  require 'embedly'
	  # require 'json'
	  embedly_api = Embedly::API.new :key => 'de58199a853c4012893443678819d1f0'
	    url = @post.url
	    obj = embedly_api.oembed :url => url
	    post.title = obj[0].title
	    post.provider = obj[0].provider_name
	    post.media_type = obj[0].type
	    post.description = obj[0].description
	    post.thumbnail_url = obj[0].thumbnail_url
	    post.provider_url = obj[0].provider_url
	    post.author_name = obj[0].author_name
	    post.embed_code = obj[0].html
	    return post
  end

end

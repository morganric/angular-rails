class PostsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:show, :index]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all( :order => "views DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

 def add_views
    @post = Post.find(params[:id])
    @views = @post.views
    num = params[:num]
    @newviews = @views + num.to_i  
    @post.update_attributes({:views => @newviews })
    @post.increases = @post.increases + 1
    if @post.save
        redirect_to @post, notice: "#{num} Views were added."
    else
      redirect_to @post, @post.errors, status: :unprocessable_entity 
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    post = Post.find(params[:id])
    @views = post.views
    if @views > 0
      @new_views = @views - 1
      @post = Post.find(params[:id])
      @post.total = @post.total + 1
      @post.update_attributes({:views => @new_views })
      @post.save
    else
      redirect_to root_url, notice: 'Sorry this post has expired'
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create

    @post = Post.new(params[:post])
    @post.total = 0
    @post.increases = 0
    @post.views = 101

    embedly_title


    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private

  def embedly_title
  require 'embedly'
  # require 'json'
  embedly_api = Embedly::API.new :key => 'de58199a853c4012893443678819d1f0'
    url = @post.url
    obj = embedly_api.oembed :url => url
    @post.title = obj[0].title
    @post.provider = obj[0].provider_name
    @post.media_type = obj[0].type
    @post.description = obj[0].description
    @post.thumbnail_url = obj[0].thumbnail_url
    @post.provider_url = obj[0].provider_url
    @post.author_name = obj[0].author_name
    # puts obj[0].marshal_dump
    # json_obj = JSON.pretty_generate(obj[0].marshal_dump)
    # puts json_obj
  end

end

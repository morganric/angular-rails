class PostsController < ApplicationController
  include PostsHelper
  require 'json'

  load_and_authorize_resource
  skip_authorize_resource :only => [:show, :index]


  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all( :order => "total DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
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
      format.js
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
    new_url = params[:post][:url]
    @exist = Post.find_by_url(params[:post]["url"])

    if @exist
      @exist.views = @exist.views + 10
      if @exist.save
      redirect_to post_url(@exist), notice: 'That post already exists here.... We added 10 views though.'
      else
        render json: @exist.errors, status: :unprocessable_entity 
      end 
    else        
      @post = Post.new(params[:post])
      @post.total = 0
      @post.increases = 0
      @post.views = 100
      @post.user = current_user


      embedly_title(@post)


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

end

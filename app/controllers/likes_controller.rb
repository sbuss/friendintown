class LikesController < ApplicationController
  before_filter :authenticate, :only => [:create, :edit, :update, :destroy]
  before_filter :authorized_user, :only => [:edit, :update, :destroy]

  def show
    @like = Like.find(params[:di])
    @user = @like.user
    @tour = @like.tour
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
      format.json  { render :json => @user }
    end
  end

  def new
    @like = current_user.likes.build
  end

  def create
    @like = current_user.likes.new(params[:like])
    respond_to do |format|
      if @like.save
        format.html { redirect_to(@like, :notice => 'Like was successfully created.') }
        format.xml  { render :xml => @like, :status => :created, :location => @like }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @like.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /likes/1
  # PUT /likes/1.xml
  def update
    @like = Like.find(params[:id])

    respond_to do |format|
      if @like.update_attributes(params[:like])
        format.html { redirect_to(@like, :notice => 'Like was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @like.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.xml
  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.html { redirect_to(current_user) }
      format.xml  { head :ok }
    end
  end
  private 
    def authorized_user
      @like = current_user.likes.find_by_id(params[:id])
      redirect_to root_path if @like.nil?
    end
end

class RatingsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :authorized_user, :only => [:edit, :update, :destroy]

  # GET /ratings/1
  # GET /ratings/1.xml
  # GET /ratings/1.json
  def show
    @rating = Rating.find(params[:id])
    @title = "Rating details"
    @user = @rating.user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rating }
      format.json  { render :json => @rating }
    end
  end

  # GET /ratings/new
  # GET /ratings/new.xml
  def new
    @rating = Rating.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rating }
      format.json  { render :json => @rating }
    end
  end

  # GET /ratings/1/edit
  def edit
    @rating = Rating.find(params[:id])
  end

  # POST /ratings
  # POST /ratings.xml
  def create
    @tour = Tour.find(params[:tour_id])
    @rating = @tour.ratings.build(params[:rating])
    @rating.user = current_user

    respond_to do |format|
      if @rating.save
        format.html { redirect_to(@tour, :notice => 'Rating was successfully created.') }
        format.xml  { render :xml => @tour, :status => :created, :location => @rating }
        format.json  { render :json => @tour, :status => :created, :location => @rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tour.errors, :status => :unprocessable_entity }
        format.json  { render :json => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.xml
  def update
    @rating = Rating.find(params[:id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to(@rating, :notice => 'Rating was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
        format.json  { render :json => @rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.xml
  def destroy
    @rating = Rating.find(params[:id])
    @tour = @rating.tour
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to(@tour) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
  
  private
    def authorized_user
      @rating = current_user.ratings.find_by_id(params[:id])
      redirect_to root_path if @rating.nil?
    end
end

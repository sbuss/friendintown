class ToursController < ApplicationController
  before_filter :authenticate, :only => [:create, :edit, :update, :destroy]
  before_filter :authorized_user, :only => [:edit, :update, :destroy]
  # GET /tours
  # GET /tours.xml
  def index
    @tours = Tour.all.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tours }
      format.json  { render :json => @tours }
    end
  end

  # GET /tours/1
  # GET /tours/1.xml
  def show
    @tour = Tour.find_by_url(params[:id])
    @stops = @tour.stops
    @ratings = @tour.ratings
    @title = @tour.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tour }
      format.json  { render :json => @tour }
    end
  end

  # GET /tours/new
  # GET /tours/new.xml
  def new
    @tour = current_user.tours.build

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.xml  { render :xml => @tour }
    #end
  end

  # GET /tours/1/edit
  def edit
    @title = @tour.name
    @tour = Tour.find_by_url(params[:id])
  end

  # POST /tours
  # POST /tours.xml
  def create
    @tour = current_user.tours.new(params[:tour])

    respond_to do |format|
      if @tour.save
        format.html { redirect_to @tour, :notice => 'Tour was successfully created.' }
        format.xml  { render :xml => @tour, :status => :created, :location => @tour }
        format.json  { render :json => @tour, :status => :created, :location => @tour }
      else
        format.html { render :action => "new", :status => :unprocessable_entity }
        format.xml  { render :xml => @tour.errors, :status => :unprocessable_entity }
        format.json  { render :json => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tours/1
  # PUT /tours/1.xml
  def update
    @tour = Tour.find_by_url(params[:id])

    respond_to do |format|
      if @tour.update_attributes(params[:tour])
        format.html { redirect_to(@tour, :notice => 'Tour was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.xml
  def destroy
    @tour = Tour.find_by_url(params[:id])
    @tour.destroy

    respond_to do |format|
      format.html { redirect_to(tours_url) }
      format.xml  { head :ok }
    end
  end

  private
    def authorized_user
      @tour = current_user.tours.find_by_id(params[:id])
      redirect_to root_path if @tour.nil?
    end
end

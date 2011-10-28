class StopsController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]

  def show
    @stop = Stop.find(params[:id])
    @title = @stop.tour.name
  end

  def new
    @stop = Stop.new
    @place = @stop.build_place
    @title = "Create stop"
  end

  def create
    @tour = Tour.find_by_url(params[:tour])
    @tour.stops.create(params[:stops])
  end

end

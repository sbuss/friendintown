class StopsController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]

  def show
    @stop = Stop.find(params[:id])
    @title = @stop.tour.name
  end

  def new
    @stop = Stop.new
    @title = "Create stop"
  end

  def create

  end
end

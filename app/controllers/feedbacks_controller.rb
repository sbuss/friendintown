class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rating }
      format.json  { render :json => @rating }
    end
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.page = session[:feedback_last_page] || nil
    @feedback.user = current_user || nil

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to(session[:feedback_last_page] || root_path, :notice => 'Thanks for the feedback!') }
      else
        format.html { render :action => "new" }
      end
    end
  end
end

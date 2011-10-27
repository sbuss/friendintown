class PagesController < ApplicationController
  def home
    @title = "Home"
    search_sort_and_paginate_tours(params)
    if signed_in?
    end
  end

  def contact
    @title = "Contact"
  end

  def send_contact
    Notifications.deliver_contact(params[:email])
    flash[:notice] = "Thanks for the message! We'll get back to you soon."
    redirect_to contact_path
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def yc
    @title = "Y Combinator winter 2012!"
  end

  def mobile
    render :layout => false
    @title = "Tourious Mobile"
  end
end

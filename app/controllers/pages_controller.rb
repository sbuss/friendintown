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

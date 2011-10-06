class PagesController < ApplicationController
  def home
    @title = "Home"
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

end

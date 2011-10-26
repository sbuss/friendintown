module ToursHelper
  def duration(tour)
    #tour.duration is in minutes
    if tour.duration > 60 * 24
      days = (tour.duration/60/24).ceil
      return pluralize(days, "DAY").upcase.split
    elsif tour.duration > 60
      hours = (tour.duration/60).ceil
      return pluralize(hours, "HOUR").upcase.split
    else
      return [tour.duration, "MIN"]
    end
  end

  def staticDirectionsMap(tour)
    base_url = "http://maps.googleapis.com/maps/api/staticmap?"
    map_params = { :size    => "130x100",
                   :maptype => "roadmap",
                   :sensor  => "true",
                   #:zoom    => 12,
                   :markers => nil }
    markers = []
    tour.stops.each do |stop|
      place = stop.place
      markers.push("size:mid|label:#{stop.stop_num}|#{place.lat},#{place.long}")
    end
    map_params[:markers] = markers.join("&markers=")
    url = base_url + map_params.map{|k,v| "#{k}=#{v}"}.join("&")
    "<a href=\"#{url}\"><img class=\"gmap-static\" src=\"#{url}\" /></a>".html_safe
  end

  # Sort tours, applying any extra relational algebra
  def sort_tours(params, alg)
    @filters = Tour::FILTERS
    if params[:sort] && @filters.collect{|f| f[:scope]}.include?(params[:sort])
      @tours = Tour.unscoped{ Tour.where(alg).send(params[:sort]) }
    else
      @tours = Tour.where(alg)
    end
  end

  # Get the relational algebra for searching for tours
  def search_tours(params)
    alg = nil
    if params[:search]
      kw = "%" + params[:search] + "%"
      tours = Tour.arel_table
      alg = tours[:name].matches(kw).or(tours[:desc].matches(kw))
    end
    alg
  end

  def paginate_tours(params, tours)
    @tours = tours.paginate(:page => params[:tours_page], :per_page => 10)
  end

  def search_sort_and_paginate_tours(params)
    paginate_tours(params, sort_tours(params, search_tours(params)))
  end
end

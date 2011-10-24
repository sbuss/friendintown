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
end

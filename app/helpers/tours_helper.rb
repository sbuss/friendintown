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
end

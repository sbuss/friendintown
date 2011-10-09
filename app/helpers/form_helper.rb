module FormHelper
  def setup_tour(tour)
    stops = tour.stops.build
    place = stops.build_place
    tour
  end
end


var loc,// Starting location
    map,
    info,
    locService,
    markers = [],
    directionsDisplay,
    directionsService = new google.maps.DirectionsService(),
    currentLoc;  
    
    
// Will refactor once working..or soon there after...or never    
function loadMap(mapDOMobj, options, stops) {
     var defaultOptions = {
            zoom: 13,
            streetViewControl: false,
            zoomControlOptions: {
              position: google.maps.ControlPosition.RIGHT_TOP
            },
            panControlOptions: {
              position: google.maps.ControlPosition.RIGHT_BOTTOM
            },
            center: new google.maps.LatLng(47.6062095, -122.3320708),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        },
        options = $.extend(defaultOptions, options);

      directionsDisplay = new google.maps.DirectionsRenderer();
      map = new google.maps.Map(mapDOMobj, options);
      directionsDisplay.setMap(map);

      locService = new google.maps.places.PlacesService(map);
      info = new google.maps.InfoWindow();
      
      //Load route if passed in
     if (stops && stops.length > 1) {
               var start = new google.maps.LatLng(stops[0].place.lat,stops[0].place.long),
                   end = new google.maps.LatLng(stops[stops.length-1].place.lat,stops[stops.length-1].place.long),
                   wayPoints = [];

               for(var i=1,l=stops.length-1;i<l;i++) {
                   wayPoints.push({location:new google.maps.LatLng(stops[i].place.lat,stops[i].place.long), stopover:true});
               }
               
             var request = {
               origin:start,
               destination:end,
               waypoints:wayPoints,
               travelMode: google.maps.TravelMode.WALKING
             };
             
             directionsService.route(request, function(result, status) {
               if (status == google.maps.DirectionsStatus.OK) {      
                 directionsDisplay.setDirections(result);
               }
             });
     }
}    
    
function initialize() {
    var myOptions = {
        zoom: 13,
        streetViewControl: false,
        zoomControlOptions: {
            position: google.maps.ControlPosition.RIGHT_TOP
        },
        panControlOptions: {
            position: google.maps.ControlPosition.RIGHT_BOTTOM
        },
        center: new google.maps.LatLng(47.6062095, -122.3320708),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    
    directionsDisplay = new google.maps.DirectionsRenderer();
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    directionsDisplay.setMap(map);
  
    // Autocomplete on the search box
    /*autocomplete = new google.maps.places.Autocomplete(
                          document.getElementById("searchBox"),
                          { bounds: map.getBounds() });
    autocomplete.bindTo('bounds', map);*/
    
  // < determine location >
  // Try W3C Geolocation (Preferred)
  // if(navigator.geolocation) {
  //    navigator.geolocation.getCurrentPosition(function(position) {
  //      loc = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
  //      map.setCenter(loc);
  //    }, function() {
  //      handleNoGeolocation();
  //    });
  //  // Try Google Gears Geolocation
  //  } else if (google.gears) {
  //    var geo = google.gears.factory.create('beta.geolocation');
  //    geo.getCurrentPosition(function(position) {
  //      loc = new google.maps.LatLng(position.latitude,position.longitude);
  //      map.setCenter(loc);
  //    }, function() {
  //      handleNoGeoLocation();
  //    });
  //  // Browser doesn't support Geolocation
  //  } else {
  //    handleNoGeolocation();
  //  }
  // 
  // function handleNoGeolocation() {
  //   loc = new google.maps.LatLng(47.6062095, -122.3320708);//Seattle
  // }
  // map.setCenter(loc);
  
  // </ determine location >
  
  
    locService = new google.maps.places.PlacesService(map);
    info = new google.maps.InfoWindow();
    google.maps.event.addListener(info, 'closeclick', function() {
      // Unselect the current marker
      console.log("info closed")
    });

}

function callback(results, status) {
    removeAllMarkers();
    var $list = $("#currentSearch ul");
    
    if (status == google.maps.places.PlacesServiceStatus.OK) {
        for (var i = 0; i < results.length; i++) {
            //Add to results list
            var li = $("<li />"),
                tmpMarker = createMarker(results[i], li);
            
            li.text(results[i].name).click(function () {
                var m = tmpMarker,
                    place = results[i]; 
                return function() {
                    $(this).siblings(".current").removeClass("current").end().addClass("current");
                    info.setContent(("<div> <span class='title'>" + place.name + "</span><br /><button id='add'>Add</button></div>"));
                    currentLoc = place.geometry.location;
                    info.setPosition(place.geometry.location)
                    info.open(map, m);                    
                }
            }())
            li.append($("<a/>").text("Add").addClass("button gray mini"));
            $list.append(li);
        }
        //Close info window
        info.close();
        
        
        if(markers.length) {
            info.setContent(markers[0].name);
            info.open(map, markers[0]);
        }
    }
}

function calcRoute() {
    var $allPoints = $("#list li");

    if($allPoints.length < 2) {
        return false;
    }
    
    var start = $allPoints.eq(0).data("loc"),
        end = $allPoints.eq(-1).data("loc"),
        wayPoints = [];
    
    for(var i=1,l=$allPoints.length-1;i<l;i++) {
        wayPoints.push({location:$allPoints.eq(i).data("loc"), stopover:true});
    }

  var request = {
    origin:start,
    destination:end,
    waypoints:wayPoints,
    travelMode: google.maps.TravelMode.WALKING
  };
  
  directionsService.route(request, function(result, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(result);
    }
  });
}


function createMarker(place, li) {
  var placeLoc = place.geometry.location;
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location
  });
  
  markers.push(marker);
   
  //Need to store current location in a better place
  google.maps.event.addListener(marker, 'click', function() {
     if (li) {
         li.siblings(".current").removeClass("current").end().addClass("current");
     }
    info.setContent(("<div> <span class='title'>" + place.name + "</span><br /><button id='add'>Add</button></div>"));
    currentLoc = place.geometry.location;
    info.open(map, this);
  });
  return marker;
}

function removeAllMarkers() {
    for (i in markers) {
        markers[i].setMap(null);
    }
    markers.length = 0;
}

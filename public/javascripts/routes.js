 function loadRoute(tour) {
     $("#list").empty();
     //Add items to list
    for(var i=0, l=tour.routes.length;i<l;i++) {
        var location = new google.maps.LatLng(tour.routes[i].lat, tour.routes[i].long);
        createListItem(tour.routes[i].name, location);
    }
    calcRoute();
 }
 
function createListItem(text, loc) {
     $("#list").append($("<li />").addClass("mapItem").text(text).data("name",text).data("loc", loc).append("<a class='remove' href='#'>[X]</a>").append("<div class='grips'></div>"));
}

function loadTour(tour) {
    //Check if the right div is displayed
    var $current = $("#focusBanner").children("div.current");
        $current.fadeOut(500, function () {
            //Update DOM
            $("#currentTour").find("h3.title").removeClass("blue purple red turq pink").addClass(tour.color).text(tour.name).end()
            .find("div.dur .number").text(tour.duration).end()
            .find("div.cost .number").text(tour.cost).end()
            .find("div.spots .number").text(tour.spots).end()
            .find("div.likes .number").text(tour.likes).end();
            
            if( $current.attr("id") === "search") {
                $("#myTour").fadeOut();
                $("#focusBanner").animate({height:185}, "linear", function() {$("#currentTour").fadeIn(500, function () {$(this).addClass("current")});});
            } else {
                $("#currentTour").fadeIn(500, function () {$(this).addClass("current")});
            }
            $(this).removeClass("current")
        });
        
    loadRoute(tour) 
}

function loadAllTours(tours) {
    if( typeof tours === "undefined") { return false; }
    
    var colors = ['blue', 'pink', 'purple','turq', 'red'],
        $newTourLi,
        $clone = $("#tourClone"),
        $list = $("<ul />");
        
    for(var i=0,l=tours.length;i<l;i++) {
        //Create tour DOM object and add it to the page...To Do: Optimization
        tours[i].color = colors[(Math.floor(Math.random()*colors.length))]
        $newTourLi = $clone.clone();
        $newTourLi.removeAttr("id").find("h3.title").addClass(tours[i].color).text(tours[i].name).end()
        .find("div.dur .number").text(tours[i].duration).end()
        .find("div.cost .number").text(tours[i].cost).end()
        .find("div.spots .number").text(tours[i].spots).end()
        .find("div.likes .number").text(tours[i].likes).end()
        .data("tour",tours[i]);
        
        $list.append($newTourLi);
    }
    $("#toursWrapper").append($list)
    
}


$(function () { 
    
    // Load tours
    $.ajax({
      url: "./data.json",
      success: function(d, textStatus, jqXHR) {
          loadAllTours(d.data)
         //loadRoute(data.data[0])//Load the first test, just for testing
      },
      error: function () {
          alert("Sorry :( We're broken. Email nibbler and he'll get right on it: Nibbler.thePug@gmail.com")
          console.log(arguments)
      },
      dataType: "JSON"
    });
    
    
    $("#createTour").click(function() {
        //Fade nonsense/expand map/shrink currentTour/fade in search
        $("#focusBanner").children("div.current").fadeOut(500, function () {$(this).removeClass("current")});
        $("#map_canvas").animate({height:600}, 1000, "easeOutQuint", function () {$("#myTour").fadeIn();google.maps.event.trigger(map, 'resize')})
        $("#focusBanner").animate({height:85}, 1000, "linear", function() { $("#search").fadeIn().addClass("current")})
        //Fade in Search and list
    })
    

    
    $("#featuredTours div.selectCover").css("opacity","0").show();
    
    // Show "select Tour" on hover
    $("#featuredTours li").live({
        mouseenter:
           function () {    
                $(this).find(".selectCover").stop().animate({opacity:0.5}, 300);
           },
        mouseleave:
           function() {
               $(this).find(".selectCover").stop().animate({opacity:0}, 300);
           }
       });

    
    
     $("#featuredTours li").live("click", function () {
         //$(this).effect("scale",{percent: 50},500);
         var newTop = $("#focusBanner").offset().top - $(this).offset().top,
            time = newTop * -2;
         
         $(this).animate({opacity:0.5}, 500, "easeInOutSine", function () {
             $(this).animate({top:newTop},time, "easeInOutQuint", function () {loadTour($(this).data("tour"));$(this).remove();})
         })
     })
    
        
         $( "#list" ).sortable({
                    placeholder: "ui-state-highlight",
                    update:calcRoute
                });
                $( "#list" ).disableSelection();
         
         $("a.remove").live('click', function () {
             $(this).parents("li.mapItem").remove();
             if($("#autoRoute").is(":checked")) {
                  calcRoute();
              }
         })
                
         $("#add").live('click', function () {
             createListItem($(this).siblings("span.title").text(),currentLoc);
            
             if($("#autoRoute").is(":checked")) {
                 calcRoute();
             }
         })
         
         
        $("#autoRoute").click(function() {
            if($(this).is(":checked")) {
                calcRoute();
            }
        }) 
         
        $("#searchForm").submit( function () {
          locService.search(
                {
                    //location: map.getCenter(),
                    //radius: '100',
                    bounds: map.getBounds(),
                    //types: ['bar'],
                    name: $("#searchBox").val()
                }, 
                callback
            );
            
            return false;
        })
        
        $("#saveButton").click(function() {
            $( "#new_tour" ).dialog( "open" );
        })
        
        $( "#new_tour" ).dialog({
            autoOpen: false,
            height: 300,
            width: 350,
            modal: true
        }).submit(function () {
            // Create routes
            var allRoutes = [],
              $hiddenFields = $("<fieldset />");
            
            for(var i=0,$allPoints=$("#list li"), l=$allPoints.length;i<l;i++) {
                  // Normally these will be added as the user adds points to his map, and reordered on reorder...well no shit Devin
                  
                  $hiddenFields.append(
                      $("<input type='hidden' name='tour[stops_attributes]["+i+"][stop_num]' value='"+i+"' />"),
                      $("<input type='hidden' name='tour[stops_attributes]["+i+"][place_attributes][name]' value='"+$allPoints.eq(i).data('name')+"' />"),
                      $("<input type='hidden' name='tour[stops_attributes]["+i+"][place_attributes][lat]' value='"+$allPoints.eq(i).data('loc').lat()+"' />"),
                      $("<input type='hidden' name='tour[stops_attributes]["+i+"][place_attributes][long]' value='"+$allPoints.eq(i).data('loc').lng()+"' />"));
                 
               }
               
            $hiddenFields.appendTo($(this));

            $.ajax({
              type: 'POST',
              url: "/tours.json",
              data: $(this).serialize(),
              success: function () { $( "#new_tour" ).dialog( "close" );}
            });
            
           
            
            return false;
        })
        
        
        
    })
 
 

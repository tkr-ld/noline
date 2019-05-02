function initMap(){
  geocoder = new google.maps.Geocoder();
  var center = { lat: -34.397, lng: 150.644 };
  let map = new google.maps.Map(document.getElementById('map'),{
  center: center,
  zoom: 15
  });

  marker = new google.maps.Marker({ position: center, map: map });
  
  var address = "#{@shop.place}";

  geocoder.geocode({'address': address}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({ map: map, position: results[0].geometry.location });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    } 
  });
} 

// Setup map
var handler;
var markers;
function setupMap(marker_json) {
    handler = Gmaps.build('Google');
    handler.buildMap({ internal: {id: 'map'} }, function(){
        markers = handler.addMarkers(marker_json);
        if (markers.length > 1) {
            handler.bounds.extendWith(markers);
            handler.fitMapToBounds();
        } else if (markers.length == 1) {
            handler.map.centerOn(marker_json[0]);
        } else {
            handler.map.serviceObject.setZoom(2);
        }
    });
}
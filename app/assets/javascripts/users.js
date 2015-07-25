function displayOnMap(position){
    $("#location").html(position.coords.latitude.toFixed(2) + ", " + position.coords.longitude.toFixed(2));

    handler.removeMarkers();
    var marker = handler.addMarker({
        lat: position.coords.latitude,
        lng: position.coords.longitude,
    });
    handler.map.centerOn(marker);

    $.ajax({
        type: "POST",
        url: "/location",
        data: { "location" : position.coords }
    });
};

function handleError(error) {
    if (error.code == 1) {
        alert("Error: you must provide access to your location.");
    } else {
        alert("Unknown error.");
    }
};

$(document).on("click", "#update-location-button", function() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(displayOnMap, handleError);
    } else {
        alert("Unsupported device.");
    }
});

$(document).on("click", "#edit-message-button", function() {
    $(this).hide();
    $("#user-message").hide();
    $("#edit-message-form").show();
});

$(document).on("click", "#submit-message-button", function() {
    showLoadingOverlay(this);
});
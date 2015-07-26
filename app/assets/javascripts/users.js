var userMarker;

function updateCurrentPosition(position) {
    displayOnMap(position.coords);

    $.ajax({
        type: "POST",
        url: "/location",
        data: { "location" : position.coords }
    });
};

function displayOnMap(coords) {
    $("#location").html(coords.latitude.toFixed(2) + ", " + coords.longitude.toFixed(2));

    if (userMarker != undefined) {
        handler.removeMarker(userMarker);
    }
    handler.removeMarkers(markers);
    userMarker = handler.addMarker({
        lat: coords.latitude,
        lng: coords.longitude,
    });
    handler.map.centerOn(userMarker);
}

function handleError(error) {
    if (error.code == 1) {
        alert("Error: you must provide access to your location.");
    } else {
        alert("Unknown error.");
    }
};

$(document).on("click", "#update-location-button", function() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(updateCurrentPosition, handleError);
    } else {
        alert("Unsupported device.");
    }
});


// Update address
function hideAddressForm() {
    $("#update-address-button").show();
    $("#update-address-form").hide();
    $("#update-address-form #address").val('');
    $("#address-container").find(".loading-overlay").remove();
}

$(document).on("click", "#update-address-button", function() {
    $(this).hide();
    $("#update-address-form").show();
});

$(document).on("click", "#cancel-address-button", function() {
    hideAddressForm();
    return false;
});

$(document).on("click", "#submit-address-button", function() {
    showLoadingOverlay(this);
});

// Edit message
var message;

$(document).on("click", "#edit-message-button", function() {
    $(this).hide();
    $("#user-message").hide();
    $("#edit-message-form").show();
    message = $("#edit-message-form #message").val();
});

$(document).on("click", "#cancel-message-button", function() {
    $("#edit-message-button").show();
    $("#user-message").show();
    $("#edit-message-form").hide();
    $("#edit-message-form #message").val(message);
    return false;
});

$(document).on("click", "#submit-message-button", function() {
    showLoadingOverlay(this);
});
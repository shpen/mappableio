// Activate loading overlay for certain ajax actions
function showLoadingOverlay(rootElement) {
    $(rootElement).closest(".loading-container").prepend("<div class='loading-overlay'></div>");
}
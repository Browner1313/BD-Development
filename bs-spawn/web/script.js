document.addEventListener('DOMContentLoaded', () => {
    const markers = document.querySelectorAll('.markerBtn');
    const spawnButton = document.getElementById('spawn-btn');
    const lastButton = document.getElementById('last-btn');
    const selectedPOI = document.getElementById('selected-poi');
    let selectedMarker = null;
    let lastLocation = null;
  
    markers.forEach(marker => {
      marker.addEventListener('click', () => {
        markers.forEach(m => m.classList.remove('selected')); // Remove previous selection
        marker.classList.add('selected'); // Highlight selected marker
        selectedMarker = marker;
        selectedPOI.textContent = marker.getAttribute('data-name');
        spawnButton.disabled = false; // Enable spawn button
      });
    });
  
    spawnButton.addEventListener('click', () => {
      if (selectedMarker) {
        const location = selectedMarker.getAttribute('data-location');
        lastLocation = location; // Save the current location as last
        // Handle the spawn logic with the selected location
        console.log('Spawning at:', location);
      }
    });
  
    lastButton.addEventListener('click', () => {
      if (lastLocation) {
        // Handle returning to the last location
        console.log('Returning to last location:', lastLocation);
        // You might want to trigger spawn at the lastLocation here
      }
    });
  });
  
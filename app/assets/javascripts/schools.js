
L.mapbox.accessToken = 'pk.eyJ1IjoiZm1hMiIsImEiOiJkcmdtd0NjIn0.dw0I__cIjfXpz37Yj0DQmw';
var map = L.mapbox.map('map', 'fma2.l3g81h30', {
    attributionControl: false,
    infoControl: true
})

// Info control 
map.infoControl.addInfo (
    '<a href="https://github.com/fma2/colocated-charters-nyc-script">Data from NYC Department of Education analyzed by F. Malik</a>');

$.ajax({
  dataType: 'json',
  url: '/',
  type: 'GET'
}).success(function(data){
  loadAllSchools(data);
});

//Function that places all schools on map
function loadAllSchools(data) {
  // featureLayer = L.mapbox.featureLayer(data).addTo(map)
  featureLayer = L.mapbox.featureLayer(data)
  clusterGroup = createClusterGroup(featureLayer)
  map.addLayer(clusterGroup);  
}
function createClusterGroup(data) {
  var clusterGroup = new L.MarkerClusterGroup();
  data.eachLayer(function(layer) {
    clusterGroup.addLayer(layer);
})
  return clusterGroup;
}

// Create a new layer with a special pointToLayer function
// that'll generate scaled points.
var schoolsLayer = L.geoJson(null, { pointToLayer: scaledPoint })
    .addTo(map);

function pointColor(feature) {
    return feature.properties.managed_by_name == "Charter" ? '#f55' : '#a00';
    // return feature.properties.mag > 5 ? '#f55' : '#a00';
}
function pointRadius(feature) {
    return feature.properties.managed_by_name == "Charter" ? 15 : 10;
    // return (feature.properties.mag - 4) * 10;
}

function scaledPoint(feature, latlng) {
    return L.circleMarker(latlng, {
        radius: pointRadius(feature),
        fillColor: pointColor(feature),
        fillOpacity: 0.7,
        weight: 0.5,
        color: '#fff'
    }).bindPopup('<h2 class="popup school-name">' + feature.properties.location_name + '</h2>' + '<h3 class="popup opening-date">' + new Date(feature.properties.opening_date).toDateString() + '</h3>' + '<p class="popup mgmt-info">' + feature.properties.managed_by_name + '</p>');
}

// Request data and add it to the schoolsLayer.
d3.json('/schools.json', function(err, data) {
    schoolsLayer.addData(data);
    setBrush(data);
});

function setBrush(data) {
    var container = d3.select('#brush'),
    width = container.node().offsetWidth,
    margin = {top: 0, right: 0, bottom: 0, left: 0},
    height = 100;
    var timeExtent = d3.extent(data, function(d) {
        return new Date(d.properties.opening_date);
    });
    var svg = container.append('svg')
    .attr('width', width + margin.left + margin.right)
    .attr('height', height + margin.top + margin.bottom);

    var context = svg.append('g')
    .attr('class', 'context')
    .attr('transform', 'translate(' +
        margin.left + ',' +
        margin.top + ')');

    var x = d3.time.scale()
    .range([0, width])
    .domain(timeExtent);

    var brush = d3.svg.brush()
    .x(x)
    .on('brushend', brushend);

    context.selectAll('circle.quake')
    .data(data)
    .enter()
    .append('circle')
    .attr('transform', function(d) {
        return 'translate(' + [x(new Date(d.properties.opening_date)), height / 2] + ')';
    })
    .attr('r', pointRadius)
    .attr('opacity', 0.5)
    .attr('stroke', '#fff')
    .attr('stroke-width', 0.5)
    .attr('fill', pointColor);

    context.append('g')
    .attr('class', 'x brush')
    .call(brush)
    .selectAll('rect')
    .attr('y', -6)
    .attr('height', height);

    function brushend() {
        var filter;
            // If the user has selected no brush area, share everything.
        if (brush.empty()) {
            filter = function() { return true; }
        } else {
        // Otherwise, restrict features to only things in the brush extent.
        filter = function(feature) {
            return new Date(feature.properties.opening_date) > brush.extent()[0] &&
            new Date(feature.properties.opening_date) < (brush.extent()[1]);
            };
        }
        var filtered = data.filter(filter);
        schoolsLayer.clearLayers()
        .addData(filtered);
    }
}
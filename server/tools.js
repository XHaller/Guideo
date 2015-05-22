var geo = require ("geolib");

var result = geo.orderByDistance({latitude: 51.515, longitude: 7.453619}, {
a: {latitude: 52.516272, longitude: 13.377722},
b: {latitude: 51.518, longitude: 7.45425},
c: {latitude: 51.503333, longitude: -0.119722}
});

console.log(result);

console.log(result[1].longitude);
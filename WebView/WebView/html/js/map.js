( function( $ ) {
// Check define
if( !$ ) { return; }

$( document ).ready( function() {
    var latlang = new google.maps.LatLng( -34.397, 150.644 );
    var options = { zoom: 16, center: latlang, mapTypeId: google.maps.MapTypeId.ROADMAP, scaleControl: true };
    var map     = new google.maps.Map( $( ".map_canvas" )[ 0 ], options );

} );

} )( jQuery );
( function( $ ) {
// Check define
if( !$ ) { return; }

$( document ).ready( function() {
    var latlang  = new google.maps.LatLng( 35.6938401, 139.70354940000004 );
    var options  = { zoom: 16, center: latlang, mapTypeId: google.maps.MapTypeId.ROADMAP, scaleControl: true };
    var map      = new google.maps.Map( $( ".map_canvas" )[ 0 ], options );
    var geocoder = new google.maps.Geocoder();

    // To application
    function applicationCallback() {
        var centerLatLng = map.getCenter();
        geocoder.geocode( { latLng: centerLatLng }, function( results, status ) {
                if( status == google.maps.GeocoderStatus.OK && results[ 0 ].geometry ) {
                    var url = "app-callback://map?";
                    url += "address=" + encodeURIComponent( results[ 0 ].formatted_address );
                    url += "&lat="    + centerLatLng.lat();
                    url += "&lng="    + centerLatLng.lng();
                    location.href = url;

                } else {
                    // do nothing...
                }
        } );
    }

    // Initial callback
    applicationCallback();

    // From application
    window.webViewCallbackSearchAddress = function( address, region ) {
        geocoder.geocode( { address: address, region: region }, function( results, status ) {
                if( status == google.maps.GeocoderStatus.OK ) {
                    map.setCenter( results[ 0 ].geometry.location );
                    applicationCallback();

                } else {
                    alert( "Address not found." );
                }
            }
        );
    };

    // Drag moved
    google.maps.event.addListener( map, "dragend", function() {
        applicationCallback();
    } );

} );

} )( jQuery );
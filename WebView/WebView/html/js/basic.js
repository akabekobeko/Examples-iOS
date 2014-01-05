
( function( $ ) {
// Check define
if( !$ ) { return; }

$( document ).ready( function() {
    $( ".to-application-text" ).click( function( event ) {
        location.href = "app-callback://test";
    } );

    window.webViewCallback = function( text ) {
        $( ".from-app-text" ).text( text );
    };

    webViewCallback( "From Application Text" );
} );

} )( jQuery );
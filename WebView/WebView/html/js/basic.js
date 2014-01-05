
( function( $ ) {





$( document ).ready(function($) {
    /**
     * A function that is called from the application.
     * 
     * @param  {String} text Display text.
     */
    window.webViewCallback = function( text ) {
        $( ".from-app-text" ).text( text );
    };

    webViewCallback( "From Application Text" );
} );

} )( jQuery );
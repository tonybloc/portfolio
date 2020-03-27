// Animation de la navigation
(function(){
    $(document).ready(function(){
        $('body').scrollspy({target: ".navbar", offset: 50});
        $("#nav-responsive a").on('click', function(event) {
            if (this.hash !== "") {
                event.preventDefault();
                var hash = this.hash;

                $('html, body').animate({
                    scrollTop: $(hash).offset().top
                }, 800, function(){
                    window.location.hash = hash;
                });
            }
        });
    });
})();
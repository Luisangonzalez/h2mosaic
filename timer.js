window.paceOptions = {
    ajax: false, 
    document: false,
    eventLag: false,
    elements: {
        selectors: ['img']
    }
};

Pace.on('start', function(){
    window.pace_start = new Date();
});

Pace.on('done', function(){
    var load_time = Math.abs(new Date() - window.pace_start);
    document.getElementById("loadTime").innerHTML = load_time / 1000.0; // in seconds
});

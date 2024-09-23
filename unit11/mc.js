var mc = {};

(function() {


// IE does not know about the target attribute. It looks for srcElement
// This function will get the event target in a browser-compatible way
function getEventTarget(e) {
    e = e || window.event;
    return e.target || e.srcElement; 
}

this.click = function(event) {
    var target = getEventTarget(event);
    while (!(target.nodeName.toLowerCase() == 'li')) { target = target.parentNode; }
    if (!target.className) target.className = 'clicked'
    else if (target.className.indexOf('clicked') == -1) 
        target.className += ' clicked'
}

}).apply(mc);

(function () {
  'use strict';

  var tableLeftPos, startSwipingPos, swipeRange;
    
  function handleSwipe (target) {
    var mouseX = window.event.clientX;
    var swipeDistance = startSwipingPos - mouseX;
    if (swipeDistance <= swipeRange && swipeDistance >= (-1 * swipeRange)) {
      target.scrollLeft += swipeDistance;
    }
  }
  
  function startSwiping (target) {
    var offsets = target.getBoundingClientRect();
    tableLeftPos = offsets.left;
    startSwipingPos = window.event.clientX;
    swipeRange = target.getElementsByTagName('table')[0].offsetWidth - target.offsetWidth;
    target.onmousemove = function() {
      handleSwipe(target);
    };
  }
  
  function stopSwiping (target) {
    target.onmousemove = null;
  }

  if( !/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
    var tablesToSwipe = Array.prototype.filter.call(document.getElementsByClassName('os-table'), function(el){
      if (el && (el.offsetWidth < el.getElementsByTagName('table')[0].offsetWidth)) {
        return el;
      }
    });
    
    if (tablesToSwipe.length > 0) {
      tablesToSwipe.forEach(function(el){
        el.classList.add('swipe-table');
        el.addEventListener('mousedown', function(){
          startSwiping(el);
        });
        el.addEventListener('mouseup', function(){
          stopSwiping(el);
        });
        el.addEventListener('mouseleave', function(){
          stopSwiping(el);
        });
      });
    }
  }
})();

(function () {
  'use strict';

  let Backbone = require('backbone');

  const SwipeTables = Backbone.View.extend({
    el: 'body',

    isMobile: /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent),
    
    events: {
      'keydown' : 'keyAction',
      'mousedown .os-table' : 'startSwiping',
      'mouseup .os-table' : 'stopSwiping',
      'mouseleave .os-table' : 'stopSwiping',
      'mousemove .os-table' : 'handleSwipe'
    },

    isSwiping: false,
    tableLeftPos: 0, 
    startSwipingPos: 0, 
    swipeRange: 0,

    isSwipable: function(target) {
      if (!this.isMobile && target.offsetWidth < target.getElementsByTagName('table')[0].offsetWidth) {
        return true;
      }
      return false;
    },

    handleSwipe: function(e) {
      const target = e.currentTarget;
      if (this.isSwipable(target)) {
        target.classList.contains('swipe-table') ? false : target.classList.add('swipe-table');
      }
      if (this.isSwiping) {
        let mouseX = e.clientX;
        let swipeDistance = this.startSwipingPos - mouseX;
        if (swipeDistance <= this.swipeRange && swipeDistance >= (-1 * this.swipeRange)) {
          target.scrollLeft += swipeDistance;
        }
      }
    },
    
    startSwiping: function(e) {
      const target = e.currentTarget;
      if (this.isSwipable(target)) {
        this.isSwiping = true;
        const offsets = target.getBoundingClientRect();
        this.tableLeftPos = offsets.left;
        this.startSwipingPos = window.event.clientX;
        this.swipeRange = target.getElementsByTagName('table')[0].offsetWidth - target.offsetWidth;
      }
    },
    
    stopSwiping: function() {
      this.isSwiping = false;
    }

  });

  const swipeTables = new SwipeTables();

})();

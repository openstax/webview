describe('backbone history helper tests', function () {
    'use strict';
    var history;

    beforeEach(function (done) {
        this.timeout(10000);

        require(['cs!helpers/backbone/history'], function () {
            history = arguments[0];
            done();
        });
    });
    describe('get fragment tests', function () {
        it('should modify fragment', function () {
            history.getFragment('/test', null).should.equal('test');
            history.getFragment('#weird route      ', null).should.equal('weird route');
            history.getFragment('should_not_be_changed', null).should.equal('should_not_be_changed');
        });
        it('should create fragment', function () {
            // root is not at the beginning of pathname
            var myPath = history.location.pathname;
            var mySearch = history.location.search;
            var myRoot = history.root;
            history.root = 'myRoot';
            var newFragment = myPath + mySearch;
            newFragment = newFragment.replace(/^[#\/]|\s+$/g, '');
            history.getFragment(null, null).should.equal(newFragment);

            // root is at the beginning of pathname, should be sliced off
            history.root = myPath.slice(0, 5);
            history.getFragment(null, null).should.equal(newFragment.slice(5));

            // reset them back to their original state
            history.root = myRoot;
        });
    });
    describe('navigate tests', function () {
        it('should cut the string down to 30 characters', function () {

        });
    });
});
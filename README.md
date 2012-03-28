# jquery.positioner & positioner.coffee

description: __keep element in fixed position during window scroll, you can limit positioning area by parent element__  
version: 1.0 (I hope it deserves)  
requires: jQuery 1.7+  
download: [jquery.positioner.js](https://raw.github.com/krzysu/jquery.positioner/master/build/javascripts/jquery.positioner.js)  
demo: [is here](http://krzysu.github.com/jquery.positioner/)


## How to use jquery.positioner?

`selector` is element that we want to position, i.e. `'#box'`  

init:     `$(selector).positionMe(options)`  
refresh:  `$(selector).positionMe('refresh')`  
destroy:  `$(selector).positionMe('destroy')`  

#### Options

In comments there are default values

    options:
      parent: selector            // null
      margin: int                 // 0
      preserveSpace: boolean      // false

-   `parent` : parent element that limits `selector` position
-   `margin` : distance between positioned element and top of the window 
-   `preserveSpace` : if `true` will add temporary element in exactly the same dimensions like positioned element to preserve page layout


## What about positioner.coffee?

Positioner.coffee is a class written in CoffeeScript that do all the magic behind jquery.positioner. So you can use it directly in your project if you like together with tests in Jasmine. Jquery plugin is in fact only other form of initialization.


## Test suite

You can test and improve positioner.coffee using my test suite. It contains of several Jasmine tests and test page where you can see it working live. Test suite is build on middleman app. It's easy:

-   clone this repository
-   run `bundle install`
-   run `middleman server`
-   go to `0.0.0.0:4567` in your browser for test/demo page
-   go to `0.0.0.0:4567/SpecRunner.html` to run Jasmine tests
-   run `middleman build` if you need JS version


## Be aware!

This plugin has one drawback. As it is written in CoffeeScript in separate files I needed to make both Positioner and Accountant classes the global ones. So the global namespace is polluted with these two class names. I will think how to fix this but just be warned so far.


* * *
Copyright (c) 2012 Krzysztof Urbas (@krzysu).

__positioner.coffee__ and __jquery.positioner__ are available under the MIT license.
# J3.js - JavaScript JavaScript JavaScript

### Due: Wednesday, October 16, 2013 @ 11:55:00 PM EDT

This completely-new project is all about JavaScript. Your goal
is to use information from Facebook and potentially other sources to
generate an interesting browser-based visualization of your friends'
activities.  At the end of this project, you will have an awesome
browser-based app running that uses JavaScript to access several
web-based APIs.  

Unlike previous projects, you will write no server-side code for the
assignment.  Also unlike previous projects, you are given a lot of skeleton code.
Please be sure to follow the comments above each function in the given
code, as well as the instructions in this specification document.


## Functionality Overview

The overall application was shown in class.  You should be sure that
it supports three critical features: *typeahead*, *path-rendering*,
and *miles calculation*.


#### Typeahead

When you type into the user box in the upper left, the dropdown display should
show all of your Facebook friends for which your strings are prefixes.
So, for example, if "ott" is typed I should see "Otto Sipe" in the dropdown. Your typeahead should also look at last names. "Si" should show "Otto Sipe" as well as other friends who happen to have "si" in their first or last name. Finally, the typeahead should match first and last names simultaneously. If I type "ot si", "Otto Sipe" should appear. Order does not matter either - "ott s" would match a friend by the name of "Smith Scott" and "Otto Sipe". The typeahead should be case insensitive.


![Sample Typeahead Implemenation](http://i.imgur.com/m0BBZ8X.png)

#### Rendered Path

Once the user has selected a Facebook entry, you should render their
checkin history on screen.  This entails grabbing the user's checkin
history, getting the relevant lat/long pairs for each checkin, and
animating them onscreen.  You should implement the "drop icon, move,
draw line" sequence that the demonstration app shows.

![Sample Path Implemenation](http://i.imgur.com/dTbzBUJ.jpg)

#### Miles Calculator

At the bottom right of the browser, a counter should display the miles
the Facebook friend has "travelled" so far.  It should update as the
path is being drawn onscreen. It should hold an integer value (with
commas) of the total distance that this person has traveled, according
to the dataset.  
![Sample Miles Implemenation](http://i.imgur.com/DjSD9SY.png)


## Code Walkthrough

We will now describe all the source files in your application.  Recall
that your entire application is browser-based, except for data we draw
from remote public information sources like Facebook.  You do not
implement any server-side component yourself.

#### `index.html`

This is all the HTML markup you will need for the project. You <i>do
not need to modify</i> this file (unless you are going for extra
credit, but more on that later). Examine the end of the file where are
the \<script\> tags are. The order in which scripts are loaded is
important. When any script defines a JavaScript variable with global
scope, scripts loaded after it have access to that global variable.

We
will walk through each of these JavaScript files and explain the
expected functionality. 

#### `main.js`

This script's entire purpose is to be the interface between the the
visualization of the data in the browser (we will call it the "view")
and the rest of the JavaScript code in your program. This script will
use jQuery to manipulate the DOM; this is the only place where you
have to work with jQuery. jQuery is a JavaScript library that provides
a cleaned-up browser-independent API to access the DOM. The library is
loaded as the first \<script\> tag in `index.html`. Don't try to open
the jQuery file in your browser and read through the code, it's
[minified](http://en.wikipedia.org/wiki/Minification_(programming\)). 

Read the comments in the skeleton file and implement all the
functions. This file makes heavy use of
[callbacks](http://en.wikipedia.org/wiki/Callback_(computer_programming\)#JavaScript). We
will use jQuery to tell us when a user triggers an interesting event. You will provide an anonymous function to each of these event callbacks to handle the event.


#### `fb.js`

This file contains all the Facebook API code. We have taken care of
the OAuth handshaking code that implements the login.  However, you need to set up your developer account. If your team does not have access to a Facebook account, talk to the course staff and we can work with you. If you plan on using your eecs485 server instead of your laptop for this project, the Facebook setup will be slightly different! Instead of localhost you will use your eecs485 domain name.

1) [Go here](https://developers.facebook.com/apps)

2) Click `create new app`

3) App Name: `eecs485-test`

4) Click `Continue`

5) Enter `localhost` under `App Domains`

6) Click on `Website with Facebook Login` and enter `http://localhost`

7) Click `Save Changes`

8) Grab your App ID and paste it in `fb.js` as the value of the `FBAppId`

From here, follow the comments in the file. Note that there are three
API "endpoints" you should access in order to gather data about a user:

* Photos (with a geolocation tag)
* Checkins
* Statuses (with a geolocation tag)

#### `map.js`

This file handles map-related issues.  As always, follow the comments
in this file. Several functions are filled in for you. Take note, this
module was written to be dumb about data -- that is, it was designed
such that any data source can be fed to it. As long as `this.points`
contains a valid array of objects, those objects should get drawn on
the map properly. This means that if you want to pull in data from
other sources (Foursquare, Twitter, etc.) the code in `map.js` should
still work.

#### `distance.js`

This component will expose you to prototypes in JavaScript. You should modify the JavaScript native object `Number` so that it has two new methods. One of those methods should pretty-print long numbers with commas (e.g. it would convert 12000 to 12,000). The other should convert numbers from degrees to radians.

The other function you should write in this file is `distanceFormula()` that will take two
geographic coordinates and return the distance between them. For this
function, use an approximation of the Haversine formula. This formula
gives you the distance over the curvature of the Earth that it would
take to travel between the points. You may use external resources to
help implement this function. Your solution must be within 5% accuracy
against the solution function we have written to get full points. The
idea here is that we want a good approximation of the distance between
two points, but you do not need to be incredibly precise.
Once you have sanity-checked this function, move on.

#### `typeahead.js`
In this file you will implement the typeahead feature described above.

Simple Test Cases:

* `Si` -> `Otto Sipe`
* `oTt` -> `Otto Sipe`
* `ot si` -> `Otto Sipe`
* `ott s` -> `Smith Scott`

#### `style.css` && `channel.html` && `index.html`

Don't touch unless you are extending the project.

## How to Deploy + Grading

You will put all these files into a directory on your local machine. In this directory, enter this command `python -m SimpleHTTPServer PORTNUMBER`. This will spin up a server on PORTNUMBER that will serve static files. You should then be able to view `http://localhost:PORTNUMBER/`. It would be wise to use the port number 400 greater than your originally assigned lowest port number - that way you don't step on your other servers. For example, if your assigned ports are 4801 and 4901, you would use 5201 for this project.

We recommend that you run on LOCALHOST on your computer. Using your eecs485 server for this project will require you to setup your Facebook Developer account differently.

WINDOWS USERS: Install *just* python. Run `python -m http.server PORTNUMBER` from the command line and you will be all set!

For grading this project, we will only be cloning your Github repo. The code sitting in your pa3 repo will be what we clone. There should be no subdirectories or files other than what we have specified (unless you do extra credit). Please specify anything anomalous in your `README.md`.

## Extra Credit (10 % max)

Extend this project in a new and interesting way! Have fun with it - be creative.

### Examples

* Bring in another API ([Twitter](https://dev.twitter.com/docs/api/1.1) of [Foursquare](https://developer.foursquare.com/docs/explore) anyone?) and do something unique with that data
* Fancy map overlays, transitions, and stunning visual effects
* Display other interesting aggregate statistics about users
* Only show Facebook friend updates if they occur within a user-provided polytope


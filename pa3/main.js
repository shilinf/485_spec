
$(document).ready(function () {

	/* 
	Notes: 

	all jQuery $("selector") calls should be in this file,
	*don't* add them elsewhere. this will probably be the only
	file making a new Obj() too. if you're confused please
	ask a GSI - but be sure to read the docs first!!!

	show and hide the spinner when anything is loading.
	only show login or logout buttons - not both
	make sure the clear map function stops the current search
	don't let glitchy UI slide - you'll lose points!
	think in terms of callbacks! it will help you fix async problems

	sometimes jquery and bootstrap dont get along, if .hide() and .show()
	don't work right use: addClass("hide") or removeClass("hide")

	Lastly: We will grade everything on the latest version of Chrome,
	so dev with Chrome for gosh sake! Use the dev tools too they're
	amazing!
	*/

	var map = new Map(this);
	var typeahead = new Typeahead();;
	var that = this;
	var fb = new Facebook(map, this, function() {
		// called on successful login
		// set typeahead data and show/hide buttons
	});

	// create dat spinner
	this.spinner = new Spinner({radius: 30, length: 30}).spin($("#spinner")[0]);
		
	this.setMiles = function(miles) {
		// update #miles_traveled div
	}

	this.setPic = function(user_id) {
		// set the src of the #user_img
		// check out http://graph.facebook.com/ottosipe/picture?type=large
	}

	this.showLogin = function() {
		// show and hide the right buttons
	}

	this.showLogout = function() {}

	this.showSpinner = function() {}

	this.hideSpinner = function() {}

	/* 
	attach all of the buttons and key press events below here
	- .login(click)
	- .logout(click)
	- #user(keyup): use typeahead.search(key, callback)
	- the call back should render the .drop_items with IDs and Names
		- attach a .drop_item(click)
	 		- start the fb search, call fb.search(id)
	 		- reset and clear #search_dropdown
	- .clear(click): remove data and reset miles/image, other UI
	*/

});


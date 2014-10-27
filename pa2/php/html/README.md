## PHP Skeleton Code

"Take it or leave it"

### Libraries

* [KleinPHP](https://github.com/chriso/klein.php#routing) for routing

* [Smarty](http://www.smarty.net/docs/en/index.tpl) for templating

* [Klein-Smarty](https://github.com/f3l1x/Klein-Smarty/) project for more source code examples

### Pre-configured Routes

* `/`

* `/album`

* `/albums`

* `/pic`

### Directory Structure

* Smarty-3.1.14/
 * Source code for the templating library
 * Don't touch this.

* static/
 * Public files to be included client-side (JavaScript and CSS)
 * EDIT these

* templates/
 * All the Smarty template files in here (HTML markup)
 * EDIT these

* vendor/ (behind the scenes)

* .htaccess

 * An apache config file for redirecting all requests to the index.php file in this directory

* composer.json (behind the scenes)

* composer.lock (behind the scenes)

* composer.phar (behind the scenes)

* index.php

 * The global router
 * EDIT this

### index.php

* All web requests to your server get routed to this file (this magic happens behind the scenes with apache using the .htaccess file).

* KleinPHP is the routing framework that parses the HTTP requests and gives you a clean interface to map URLs to functions (more importantly, templates).

* You should pretty much only be adding `$klein->respond` calls in the middle. The rest is setup for you :)
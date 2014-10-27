## HTML Templates with Smarty

Note the use of passing variables (like "title") from index.php to the templates.

See [the Smarty docs](http://www.smarty.net/docs/en/index.tpl) for syntax reference.

The `{* Smarty *}` at the top of each file is a comment, and is just used as convention.


* album.tpl

* albums.tpl

* base.tpl

 * Everything inherits from this. Only have to write this boilerplate HTML code once!

* index.tpl

* pic.tpl
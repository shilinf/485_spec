## PHP Skeleton Code

### How to Install (7 Very Easy Steps!)

1) Log into your machine: `ssh UNIQNAME@eecs485-NUMBER.eecs.umich.edu`

2) `cd ../GROUPNAME`

3) `git clone git@github.com:EECS485/admin.git`

4) `chown -R UNIQNAME:GROUPNAME admin`

If you have trouble cloning (`fatal: Could not read from remote repository.`) then follow [this tutorial to set up your ssh keys with Github](https://help.github.com/articles/generating-ssh-keys).

5) `cd admin/php`

6) `bash setup.sh mattman GROUPNAME 4801 PORTNUMBER1 4802 PORTNUMBER2`

You must provide "mattman" "4801" and "4802" in that command, just replace the constants with your team's. Refer to conf/README.md if you have trouble configuring two ports, or just want one.

7) `httpd -f /home/GROUPNAME/admin/php/conf/httpd.conf -k start`

You can always run `.... -k stop` or `.... -k restart` to stop or restart Apache.

Use the command `ps aux | grep GROUPNAME` to see whether or not your Apache server is running. There should be a few httpd processes running.

#### Congratulations!

Your server should be up @

eecs485-NUMBER.eecs.umich.edu:PORTNUMBER1/

eecs485-NUMBER.eecs.umich.edu:PORTNUMBER2/

Start by editing html/index.php and then html/templates/templates/

### App Architecture

![PHP Architecture](https://raw.github.com/EECS485/admin/master/php/PHP_Architecture.png)

### Directory Structure

* conf/
 * Apache Config Directory
 * EDIT THIS
 * Go to all the TODOs and make the appropriate changes

* html/
 * Your code here for PA1

* run/
 * An apache folder that you need. Don't mess with it.

* access_log
 * Apache appends this file with info about every incoming web request
 * Useful to inspect for debugging

* apache_setup.md
 * Deprecated setup for apache. Please follow the new instructions at the top of this README.

* error_log
 * Apache errors go here. If you have trouble running the server, check this file

* httpd-error.log
 * Apache stores server-side error messages here (Especially HTTP 500 errors)
 * Useful to inspect for debugging

* setup.sh
 * Run this script with your group name and desired port number to setup apache
 * Example: `bash setup.sh group1 2520`

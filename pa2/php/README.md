## PHP Skeleton Code PA2 & Beyond!


### How to Install (4 Very Easy Steps!)

1) Log into your machine: `ssh UNIQNAME@eecs485-NUMBER.eecs.umich.edu`

2) `cd ../GROUPNAME && wget http://mattkneiser.com/install.sh`

3) `bash install.sh GITHUB_REPO_NAME GROUPNAME UNIQNAME PORT1 PORT2`

4) Profit $$


Your server should be up @

eecs485-NUMBER.eecs.umich.edu:PORT1+200/

eecs485-NUMBER.eecs.umich.edu:PORT2+200/

### Two Quick Notes

Since you are extending functionality from your website in PA1, copy and paste your previous code into the new directory.

When you do this, you will have to modify two lines of the main index.php file. You will need to modify the paths for KleinPHP and Smarty. Refer to the original the admin/pa2_php/html/index.php lines 4 & 18 to see how this is done.


### New Directory structure


![Alt text](http://www-personal.umich.edu/~chjun/eecs485/dir.png)

For the following projects, you only need to clone your project repo under `html`.

### For the students who don't use Klein&Smarty (which is highly not recommended!)

Delete the .htaccess file in `html`.

Rename the directory that gets cloned from "pa2_secret" to "secret".

Please put the URL for your home page in your README.md.


## Setup Github SSH Keys

1) ssh into your eecs485 server!

2) `cd ~/.ssh`

3) `ssh-keygen -t rsa -C "UNIQNAME@umich.edu"`

4) [Press Enter] Three Times

5) ``eval `ssh-agent -s` `` PLEASE NOTE THE USE OF BACKTICKS(the key next to the 1 on your keyboard)! THIS->` NOT A SINGLE APOSTROPHE ->'

6) `ssh-add id_rsa`

7) `cat id_rsa.pub`

8) Copy the contents of the file that was just printed out to the command line. It should end with your email address!

9) Follow[ step 3 here](https://help.github.com/articles/generating-ssh-keys).

10) You now have full access to your Github repo!

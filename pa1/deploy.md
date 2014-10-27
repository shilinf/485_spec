# Run your App `Forever`

*Having your non-PHP app running is **not** a requirement for this class. It just needs to be deployed (via git)
in your group directory. But, if you wanna show your friends (or mother) keeping the app running is obviously necessary.*

Tired of typing `python app.js` and losing your app when you logout?

Thanks to the great folks at Nodejitsu there is a node.js application for monitoring 
applications called [Forever](https://github.com/nodejitsu/forever).
It is intended for use with Node.js (obviously), but its simple enough to use in python too.

Note: There are other options other than `forever` for python that make much more sense
 (`supervisord` is popular) but, `forever` is much much easier to use for this class.


### FOR PYTHON KIDS ONLY:

Make sure your app runs fine with gunicorn inside the (venv) first. If you cant get it to work thats fine.

Make a file: start.sh:

	source venv/bin/activate
	gunicorn -b 0.0.0.0:3000 -w 4 app:app

`chmod u+x start.sh`  
`forever start -c bash start.sh`

And thats it! Your server is running!  

Now all the output will go to a logfile somewhere in `~/.forever/xxx.log`. Make sure you can run `./start.sh`
fine before you start it with `forever`. Otherwise you'll need to look at the logs to see errors. Don't
try and dev with `forever` its a pain to keep restarting it.

### FOR NODE KIDS:

`forever start app.js` - thats it! #noderocks

### More Forever Goodness:

`forever list` shows something like this:

	info:    Forever processes running
	data:        uid  command script   forever pid logfile                          uptime       
	data:    [0] WmtR bash    start.sh 376     378 /home/ottosipe/.forever/WmtR.log 0:0:1:22.144

`forever stop 0` stop the app 0
`forever restart 0` restart the app 0

Note: you will not be the only one using forever, so your index (0) may change. Use the list command and identify your app with its log file ex: `/home/ottosipe` or `/home/group20`. Please be nice and leave others' apps alone.

Happy Hacking!

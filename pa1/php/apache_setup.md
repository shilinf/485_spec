## PA1 with Apache
You will not have administrative access to your development machine. However, it is not 
required; Apache and MySQL will happily run as a normal user, provided they are configured 
appropriately. In this tutorial you will use the provided configuration files 
for MySQL and Apache, start the servers, and display a simple web page which will display 
correctly only when all the tools are working together.

### Starting and Configuring Apache
This is the [official documentation](http://httpd.apache.org/docs/2.2/) for the version of Apache which we use in this course.

From here, this explains how to run a separate Apache instance without root access to the 
server.

1. Make a directory, say `apache`, in your group directory (`$group`).

2. Make four directories under `apache`. These are `conf`, `run`, `html`, and `html1`. The first 
directory `conf` will hold your own configuration file, `run` will hold pid file for each apache 
instance, and both `html` and `html1` are document directories you will work in (I already made 
these directories with secret key).

3. Copy default configuration files to your conf directory by typing following command: 

        cp /etc/httpd/conf/* /home/$group/apache/conf/

4. Open `httpd.conf` and edit following directives:

    a. Find `PidFile` and modify the location to `/home/$group/apache/run/httpd.pid`.

    Apache instances check before running if this file is already created. Thus, this file should not 
    be shared.

    b. Find `Listen`, and change to assigned ports. You will listen two ports, so there should be two 
    lines of Listen directives.

    c. Find `Include conf.d/*.conf` and change it to `Include conf.d/php.conf`. I haven’t 
    found how to resolve this issue gracefully, and this is a workaround. (The original directive 
    means include all configuration files under the directory, but some of them required sudo 
    access.)

    d. Find `ErrorLog` and change the location to, for example,

        ErrorLog /home/$group/apache/error_log

    e. Find `CustomLog` and change the location to, for example,

        CustomLog /home/$group/apache/access_log combined

    Be careful since there are many `CustomLog`s which are commented out.

    f. Go to the last line, and you will find configurations for virtual hosting. Enter like the following.

    ```xml
    <VirtualHost *:5000> 
            DocumentRoot /home/$group/apache/html
            ErrorLog "/home/$group/apache/httpd-error.log"
            <Directory "/home/$group/apache/html">
            DirectoryIndex index.html index.php
            Order allow,deny
            Allow from all
            </Directory>
    </VirtualHost>
    ```

  You should have each copy of <VirtualHost> for each port. Each directive should point different 
  `DocumentRoot`, and `Directory`. You don’t necessarily need to specify different `ErrorLog`.

5. Save the file and exit.
6. Start apache server by typing (this should be absolute path)

      apachectl -f /home/$group/apache/conf/httpd.conf -k start

7. If you want to kill processes, type

      pkill -u $your-account httpd

  This is also a workaround (if you run your own server with root access, you would use 
  `apachectl -k stop`).
8. Now you should be able to see your web pages in html (or html1) directories by typing 
following URLs in your web browser:

          http://$host:$port

  In order to deliver your projects, make directories as below:

          apache/html/$secret-string/pa1

          apache/html1/$secret-string/pa1

  And store your deliverables in these directories. `$secret-string` should have been emailed 
  to you with your machine name and port numbers.

### Further Documentation

* [Detailed information on each directive](http://httpd.apache.org/docs/current/mod/directives.html)

* [Virtual hosting examples](http://httpd.apache.org/docs/2.0/vhosts/examples.html)

* [Further documentation on the apachectl program](http://httpd.apache.org/
docs/2.2/programs/apachectl.html)

### Individual programming assignment directories
For programming assignment 1, we will be checking your two websites at the following URLs:

    http://$host:$port1/$secret/pa1

    http://$host:$port2/$secret/pa1

#### For Example

    http://eecs485-01.eecs.umich.edu:12345/ao87jjmxs/pa1

    http://eecs485-01.eecs.umich.edu:12346/ao87jjmxs/pa1

Each programming assignment must have its own directory within the directory with the same 
name as the secret random string assigned to your group.

    apache/html/$secret/pa1

    apache/html/$secret/pa2

For PA1, the index.php file in the `apache/html/$secret/pa1` directory must 
display correctly in a web browser.

### Check your website
With Apache running, check the webpage in the `apache/html/$secret/pa1` (`http://
$host:$port1/$secret/pa1`) directory, and ensure that php module is running correctly by with the php function `phpinfo()` (this is what you should always do after installing apache and 
php). You can create first php file by typing (don’t paste, type it - due to double quote):

    echo "<?php phpinfo();" > index.php

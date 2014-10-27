#!/bin/bash

# Author: Matt Kneiser
# Date:   9/15/2013
#
# This script takes many parameters!
# (1) The current group name in the httpd.conf file  (Default: mattman)
# (2) The new group name to replace (1) with
# (3) The first port number in the httpd.conf file   (Default: 4801)
# (4) The first port number you would like to substitute for (3)
# (5) The second port number in the httpd.conf file  (Default: 4802)
# (6) The second port number you would like to substitute for (5)
first_argument=$1;
second_argument=$2;
third_argument=$3;
fourth_argument=$4;
fifth_argument=$5;
sixth_argument=$6;

if [ "$first_argument" ] && [ "$second_argument" ] && [ "$third_argument" ] &&
    [ "$fourth_argument" ] && [ "$fifth_argument" ] && [ "$sixth_argument" ]; then
    echo "Setting up the Apache server config file...";
    echo -e " replacing:\t[$first_argument]\twith:\t[$second_argument]";
    echo -e " replacing:\t[$third_argument]\twith:\t[$fourth_argument]";
    echo -e " replacing:\t[$fifth_argument]\twith:\t[$sixth_argument]";

    # Change the groupnames in directories
    sed -i s/$first_argument/$second_argument/g conf/httpd.conf

    # Change/substitute first port number
    sed -i s/$third_argument/$fourth_argument/g conf/httpd.conf

    # Change/substitute second port number
    sed -i s/$fifth_argument/$sixth_argument/g conf/httpd.conf
else
    echo "Error: You must provide six parameters to this script:";
    echo " (1) The current group name in the httpd.conf file  (Default: mattman)";
    echo " (2) The new group name to replace (1) with";
    echo " (3) The first port number in the httpd.conf file   (Default: 4801)";
    echo " (4) The first port number you would like to substitute for (3)";
    echo " (5) The second port number in the httpd.conf file  (Default: 4802)";
    echo " (6) The second port number you would like to substitute for (5)";
fi

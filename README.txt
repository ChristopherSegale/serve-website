Serve Website

This is an application that is used in order to create deployable websites, especially those which are static.  The contents of the website are created using 'contents.wpt'.  Look into the file in order to learn more how to write a website using it.

Output and formatting of the website is handled with the 'expander-functions.lisp' file.  The functions which are in that file are expanded within macro calls in order to create handlers for the web server which will serve a webpage when a specific url is given.

The file 'package.lisp' contains the constants which determine the port that the application is listening to as well as the document root directory that the website will use in order to hold files that the website needs.

Dependencies
This program has the following dependencies:
Bourdeaux Threads
Hunchentoot
CL-WHO (soft dependancy)

Build Instructions
Issuing the 'make' command will build the deliverable which will run your website.  If you are using an implementation different from SBCL, you may have to change various flags, most notably 'LISP', 'LISPFLAGS', and 'CACHE'.

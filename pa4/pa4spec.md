# Assignment 4: Information Retrieval

### Due Monday, Nov 4, 2013, at 11:55:00 PM

In this assignment you will learn how to build and maintain an inverted index, and use it to do simple search queries.
## Overview
For this assignment, you will allow users to search for photos with a
text query. You should implement this search feature with an inverted
index that will enable efficient retrieval of documents relevant to
the user's query.  

Your tool should run in two phases: "index-time" and "query-time".
The index-time phase occurs after your search engine has acquired a
text corpus, prior to any query processing.  Your code should read the
collection of text, compute the index, and write it to disk.  Then
later, immediately prior to query-time query processing, your search
application should load the index from disk into memory.

(Note that unlike many search engines, the corpus will be small enough
that you can build the entire index in memory.)

When a user enters a search query, you will use this loaded in-memory
inverted index to rank photos for the user. You should load the
following XML file of 200 photos with captions into your image
database (perhaps the photo table).

* [images and search.xml](http://www-personal.umich.edu/~chjun/eecs485/pa4_files.zip).

* [Portion of the sample Inverted Index](http://www-personal.umich.edu/~chjun/eecs485/sample.txt).

You will index all of the captions for this set of photos. Treat each
caption as a separate (small) document, with its own doc-id, etc. A
"hit" with this search index will be a photo, not a traditional web
page. All the files related to your inverted index should be stored in
the pa4/index/ subdirectory. The link above describes
a sample inverted index format. Your data structure should probably be
roughly similar, but does not have to be exactly the same; you may,
for example, want to add special query features that require
additional information in the data structure. Of course, the contents
of the index will depend on the documents you process.

When building the inverted index file, you should use a list of
pre-defined stopwords to remove words that are so common that they do
not add anything to search quality ("and", "the", "etc", etc). You can
find a list of these words at: 

* [Stop words](http://jmlr.csail.mit.edu/papers/volume5/lewis04a/a11-smart-stop-list/english.stop)

The textbook from which we get some of the assigned reading is
especially helpful for this assignment:
* [Information Retrieval](http://nlp.stanford.edu/IR-book/information-retrieval-book.html)

Unlike earlier PAs, only a small amount of your code for PA4 will be
in PHP/Python or JavaScript. You can choose to write most of your code in
either C++ or Java. 

## System Design

To get you started, we have provided a skeleton code framework. It consists of some source code as well as compiled libraries. The following diagram shows the relevant software components.

![Framework](http://www-personal.umich.edu/~chjun/eecs485/p1.png)

Figure 1: Framework of the system

**`Web Pages`**: You will create a search front-end in PHP/Python. 
It contacts a back-end server that processes search queries and returns 
hits to your web app. Your code will then render the results onscreen to the user. 
We have provided a PHP/Python library to you that hides the details of
communicating with the back-end server; you should simply pass in a
target portnumber and a search string. 

**`IndexServer`**: The IndexServer loads an inverted index from disk and uses it to process 
search queries. When the IndexServer is run, it will load the inverted index file into memory 
and wait for queries. Every time you make an appropriate call using the PHP/Python library, the IndexServer 
will invoke a virtual processQuery() method that you will implement. This processQuery() method 
is provided with the user's search string, and must return a list of all the "hit" docids, along with 
relevance scores. The results of the search() method are then returned to your web app via the network and the PHP/Python API.

**`Indexer`**: This is where you create your inverted index. 
The input of Indexer is the captions file which you download from images and search.xml, 
and the output is the inverted index file.


Here are the libraries and source files you will need.

* [C++ Library](http://www-personal.umich.edu/~chjun/eecs485/pa4_C++.tar.gz)
* [Java Library](http://www-personal.umich.edu/~chjun/eecs485/pa4_Java.tar.gz)
* [PHP connector(server.php)](http://www-personal.umich.edu/~chjun/eecs485/server.php)
* [Python library](http://www.python-requests.org/en/latest/)

### How to use the provided Library (Java and C++)

You may write your project in Java or C++. There are language-specific
sets of code and libraries to help you. Clearly, you should pick one
language and just one library. 

#### For the Java Library:

After unzipping the pa4_Java.tar.gz, you will get a pa4 folder. Under
pa4, the only two files that you should add code into are
src/edu/umich/eecs485/pa4/Indexer.java and
src/edu/umich/eecs485/pa4/IndexServer.java.  
Please don't modify any other file in the library. 

**`Indexer.java, IndexServer.java`**: You will need to fill out some specific functions. The code contains hints as to where you should place your own code. Please do not modify the command-line parser or the constructor. You may add other functions or data structures to these source files. You should be able to build and run your indexer and index server without modifying any other files under the pa4 folder. 

1) Build and Run: Go to pa4 folder,
    To build your code: `ant dist`

2) To run the indexer:

    java -cp dist/lib/pa4.jar:lib/json-simple-1.1.1.jar edu.umich.eecs485.pa4.Indexer

3) To run the server:

    java -cp dist/lib/pa4.jar:lib/json-simple-1.1.1.jar edu.umich.eecs485.pa4.IndexServer <portnum> index.txt

The port number you pick will be the port number that your IndexServer listens on. 
Thus, it must be different from the HTTP port numbers that your web server opens. 
Pick a random 4-digit number.  Please tell us which port number you chose in your README.

#### For C++ Library:

After unzipping the pa4_C++.tar.gz, you will get a pa4 folder. Under pa4, the only 
four files that you should add code into are `Indexer.cpp&Indexer.h and Index_server.cpp&Index_server.h`, and you only need to add your code 
in Index_server::init, Index_server::process_query and Indexer::index, and add other functions and data structures as necessary. However, you cannot delete any function 
from the original files. We will use the provided MakeFile to build your code.

1) Build and Run: Go to pa4 folder, To build your code:
      `make`
      
2) To run the indexer:
    `./indexer input.txt output.txt`

3) To run the server:
    `./indexServer <portnum> <indexfile>` 

The port number you pick will be the port number that your IndexServer listens on. Thus, it must be different from the HTTP port numbers that your web server opens. Pick a random 4-digit one.  Please tell us which port number you chose in your README.

####To connect your PHP code to the IndexServer: (For Java and C++)

Here are the steps you should follow: 

* `require "server.php";`   //enable you to use the library
* `$myResults = queryIndex(portnumber, "localhost", $query_words);` //send a query to the server, the first parameter is prot number which you used to start your server. The second parameter is hostname which is “localhost”; the third one is the query the user typed in. 
* $myResults is an array. You can use var_dump($myResults) to see the details of the data structure.


####To connect your Python code to the IndexServer: (For Java and C++)

Here are the steps you should follow: 

* `import requests`   //enable you to use the library
* `result = requests.get('http://localhost:PORTNUMBER/search?q=QUERY')` //send a query to the server
* result is an array. You can use `print result.text` to see the details.


## Search

After finishing the previous part, you will have a small search engine. 
Please create a new web page `/search` to be your search homepage. 
In this project, you can assume anyone who is in `/search` can use your search engine.
Your engine should receive a simple AND, non-phrase query (assuming the words in a query are independent), 
and return the ranked list of images. No in-doc position information is necessary for the inverted index. 
However, frequency information IS necessary inside the inverted index, so that tf-idf can be computed. 



### Using TF-IDF to score the documents

We use the normalized similarity formula to calculate the sim(Q, D) score.

It is critical that your search feature use the inverted index for answering all queries. 
Because the set of photos is relatively small, you could probably iterate directly through all of the 
comment strings without a huge computational burden. However, the purpose of this assignment is to learn 
about the inverted index. With an inverted index, we could scale your
system up to very large document collections; that scaling would be impossible
if you simply examine the comment strings directly.  If your search
feature simply examines the comment strings directly,  you will not receive any credit.

### Finding Similar Pictures

Your photo should also implement a feature for retrieving photos that
are similar to a given "query photo".  That is, after clicking a
picture the user should be able to see a list of photos that are the
most relevant to the picture. Recall that to the search engine, a
"query" and a "document" are basically the same thing; to implement
this feature, simply take the caption string as a query, and
return the results. 

### Search Results
The SERP (Search Engine Results Page, `/search`) should present a
nice-looking list of hits, with photo thumbnails next to each.  Please
show the number of results you get, as Google does when processing a
search query.  

## Extra Credit

Extra credit is given to the groups that can add one or more of the following features to their websites. There is a 2% bonus for each of the features.

* Implementing phrase queries.  This requires modifying the inverted index so that it maintains position information.
* Updating the index file in place: Upon modifying a caption, the user should be able to update the index file with the new caption, without reindexing the entire caption set.

If you have successfully implemented at least one of above mentioned, please describe it in README.txt 
including where to, how to, and what to check. 

## Submitting Your Assignment

In the `README.md` at the root of your repository please provide the following details:

* Group Name (if you have one)
* List `User Name (uniqname): "agreed upon" contributions`.
* Details about how and if you deviated from this spec - avoid if possible.
* Extra details about how to clone and run your code - simple as possible.
* Anything else you want us to know, like how many late days you took.
* The formatting is not critical, we just need the information.

```
Group Name:   
  Rabid Ocelots
Members:
  Otto Sipe (ottosipe): setup the database, setup the routes, did the project alone  
  ...
Details: 
  The homepage URL for this project is ...
  We called our /pic endpoint /foto
  We implemented the extra credit(2)
Deploy: 
  (just an example)
  pip install < requirement.txt
  foreman start
Extra:
  I took 2 late days.


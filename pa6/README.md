# Assignment 6: The Next Great Search Engine
### Due Thurs, Dec 12, 2013, at 11:59 PM

In this assignment you will build an integrated Web search engine that has several features:
* Ranking based on both tf-idf and PageRank scoring
* Indexing implemented with MapReduce so it can scale to very large corpus sizes
* An HTML and JavaScript-powered search engine interface with three special features: user-driven scoring, “deep page summarization” and a brand-new feature of your choosing

You have now learned enough in class to build a scalable search engine that is genuinely different from 
any out there today.  This assignment is your chance to build it.

## Part 1.  Integrated Ranking
So far we have computed both tf-idf and PageRank, but we have not done so together. 
Now is the time to fix this oversight.  Your search engine should rank documents based on both 
the query-dependent tf-idf score as well as the query-independent PageRank score.  

The formula for the score of a query q on a single document d should be:

	Score(q, d) = (w * PageRank(d)) + ((1-w) * tfIdf(q, d))

where w is a number between 0 and 1.  This value w should be a query-time parameter of your search system. 
Your ranker in the past received a query string q as input and emitted a ranked list of documents. 
Your new ranker should also take a parameter w, then score documents according to the formula above. 
Your ranking results should be computed by a separate index-lookup-and-rank program, as you did in PA4. 
However in this project, you need to implement Indexer using MapReduce, and modify IndexServer a bit to emit 
correct search result.

Integrating PageRank scores will require a second index, which maps each document id to its corresponding 
precomputed PageRank score. This index should be accessed at query time by your separate ranker program. 
This index should be loaded when the separate search ranker program starts up, then kept in memory.

You will build an index over the Wikipedia corpus that you used in PA5. 
However, you must now process the actual Wikipedia content, not just the link graph.

Your search engine interface should have a JavaScript-enabled slider that allows the user to adjust  the parameter w. 
Adjusting it should be optional: set it to a reasonable default and allow the user to decide whether or not to adjust it.

## Part 2.  MapReduce Indexing
Constructing an index over a very large corpus requires that we build it using many machines. 
The MapReduce framework offers a helpful tool for building the distributed indexer.

You should reimplement your inverted index software using the MapReduce framework. 
We will provide a local installation of the Hadoop open-source project. 
You will not actually run your program on hundreds of nodes: It’s possible to run a MapReduce program 
on just one machine: your local one.  However, a good MapReduce program that can run on a single node 
will run fine on clusters of any size.  In principle, 
we could take your MapReduce program and use it to build an index on 100B Web pages.

The output of your MapReduce program will be the inverted index that you load in Part 1. 
There is no need to reimplement PageRank in this way: you can use the code you wrote in PA5.

Hadoop MapReduce can use many different programming languages, 
but we strongly recommend you use Java.  Non-Java Hadoop programs add deployment complexity that 
we may not be able to help with.

## Part 3.  The New Search Interface

The third component of your project is a new HTML interface for the search engine. This should roughly follow the standard Google model: a search box for text queries, a Search button, 
and a result list of ten blue links.

However, your interface should have three features that mark it as new.

1) **Slider**  The slider to control w, described above.

2) **Deep Page Summary**  Unlike standard search engines, you know that your search engine will be used on Wikipedia pages.  Because Wikipedia pages have a more regular structure than standard Web pages, your summary snippet can be much more interesting than what Google can do for a standard page.

In particular, your search engine should:

* By default, show only the URLs on the search engine result page.
* When a special “show summary” button is clicked, use JavaScript to display several pieces of information: the first image from the page, the page “categories”, and all data from the Wikipedia page’s infobox.
* Have this information be “retractable” to minimize clutter on the screen.  That is, a click should show the extra info, and another click should hide it.

3)  **Your Pick**  Build any new interface feature of your choosing. There are no strict requirements for this: you can use your imagination to create any feature you like.  However, it should be obvious to the user and should take non-trivial work to implement.  Think of something that’s roughly equal in scale to #2 above.

We will grade this portion of the project on a “check, check-, check+” scale. 
We expect that most of the class to be in the middle “check” category, with both “check-” and “check+” being rare.

We are hoping to see some very fun stuff for this feature.  Please do your best!

We want to encourage you to come up with your own ideas. However, here are a few items to think about in case you're stuck:

* Link visualization -- draw a portion of the link graph around each hit, and permit the user to visually explore neighboring connected nodes.  Use data mining techniques to either cluster nodes together (to permit the graph to be more easily drawn) or to classify the document topic.

* Page classification -- classify pages to several categories, for example, Politics, Education, People and so on. You're allowed to 
use external text packages as the training set. 
  
4) **Miscellaneous**  Because all of your projects will differ slightly, grading this assignment will be a special challenge for us. Please make life easier and write a high-quality README that describes exactly how we should build, run, and test your code. It is especially helpful if your README contains screenshots and a small "tutorial" section that describes how we can exercise the best features of your assignment.


## Additional Notes
Other technical notes on running MapReduce program including 
* Installation of the software
* [Here](https://github.com/EECS485/admin/blob/master/pa6/pa6_notes.md) is the explanation about the dataset we will use.


## Grading

The only extra credit available for this assignment is in the “Your Pick” portion of Part 3 above.  Receiving a “check+” on that feature will add a 5% credit to your project grade.

Please write a bash script to generate inverted index files and PageRank values in the directory `pa6_secretString/invoutput` and `pa6_secretString/proutput`. In other words, if we type

	eecs485pa6inv.sh

the output files from your inverted index MapReduce program should be stored in pa6_secretString/invoutput, and if we type

	eecs485pa6pr.sh

Output files from your PageRank (non-MapReduce) program should be  stored in pa6_secretString/proutput. Make sure if the scripts run OK when we type the same script repeatedly. 
You should make the cleaning task include removal of old output directories, etc. 
The example as to how to run MapReduce program is included in the code we provide.  
Modify them appropriately following the instructions here.

Also, we should be able to see the results by typing

		cat invoutput/*

and

		cat proutput/*

## Submitting Your Assignment

Please keep your proutput and invoutput in eecs server, and specify the path in README.

Put your scripts and java source code you made in pa6_secretString directory. 
You can put MapReduce program or related library in any other place, but please keep your pa6_secretString directory 
well organized for us to grade faster.

The desired format of the output files is shown below, and the format will not be quite 
different from the one we followed in the previous assignment.

### For Inverted Index
Your MapReduce program should compute both inverted index itself and tf- idf scores for each pair of term and document. The output format should be as follows (the tf-idf scores in the below example are not correct):
	
	word	DF pageDid:tf-idf					
	yi	1 303:3.8291e-02
	york	2 359:9.6016e-02 303:3.6233e-02
					
If stated in C printf format:
			
	printf("%s\t%d",word, document-frequency);
	for *number of posting list* {
		printf("%d:%.4e ", pageDid, tf-idf score);
	}
				
The tab separation between key and value is done by default.
					
### For PageRank					
Basically same as in the previous assignment.
	
	pageDid, PR_value				
	303, 3.2313e-02
	10293, 1.2933e-06
				
The only difference is that you should print 4 digits after decimal points. 

### README format

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
  We implemented the extra credit...
Deploy: 
  (just an example)
  pip install < requirement.txt
  foreman start
Extra:
  
```

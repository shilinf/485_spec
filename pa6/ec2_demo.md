## EC2 Demo

Using EC2 for this project is worthwhile for two reasons:

1. You can learn how to use Amazon Web Services!
2. You'll not have to fight with others or with CAEN for compute time.

While CAEN and the EECS485 boxes are powerful, they have really awful
problems with shared resources. Plus you cannot let a job run in the background
on CAEN (lookup `nohup`). Having your own VM is much better and much less
of a hassle (once it's setup)!  
 
Luckily for you, I tell you how to do it, and did all the hard stuff already!

1. Sign up for AWS. This shouldn't be too hard, but you'll need a credit card.

  1a. Go to [aws.amazon.com](http://aws.amazon.com) and follow their instructions to setup a developer account. (You will probably get a phone call to confirm a PIN code).
  
  1b. If you did it right you should see a success page. Click the orange link pictured here
  
  ![AWS 1](http://i.imgur.com/Sx6FnBJ.png)
  
  1c. On the next page, log in to your developer account
  
  ![AWS 2](http://i.imgur.com/rkxn1iB.png)

2. Go to the main AWS console and click on `EC2` in the top left.  
![Pic 1](http://i.imgur.com/BWDo8vP.png)
3. You're now on the `EC2 Dashboard`. Click `Launch Instance`.
![Pic 2](http://i.imgur.com/EGXHp8k.png)
4. Let's go with Ubuntu Server 12.04. Why? Cause I feel like it.
![Pic 3](http://i.imgur.com/96Yl9oF.png)
Optional:
This is the point where you have the option to upgrade from a micro instance (which is the default). The micro instances only have `.613GB` of memory. A `m1.medium` or `m1.large` would churn through this much faster, but will cost more (again, micro is free if you're new!) Use this [Pricing Calculator](http://calculator.s3.amazonaws.com/calc5.html). About 20 hours on a large will set you back a whopping $4.80. If you're daring (and I know you are) watch a `c3.8xlarge` obliterate this project but 1 hour will cost you $2.40. :)
 **BUT PLEASE DONT FORGET TO TURN YOUR BOXES OFF WHEN YOU'RE DONE!**
 Also, if you're playing around with box sizes, start small to debug. Once you're confident try out a bigger box for speed.
![Pricing](http://i.imgur.com/3QKyZwJ.png)

5. Ignore this security warning! And `Launch` the sucker.
![Pic 4](http://i.imgur.com/R3QU7p1.png)
6. You need to create/download a keypair for this instance! Call it `485-hadoop-myname` or whatever you want. 
7. (Do NOT lose this. If you don't have it there's no way to get into your machine. You can share this with 
8. groupmates - though usually sharing keys is a bad idea...)  
![Pic 6](http://i.imgur.com/fQrXH8q.png)
7. Click `Launch Instance`!
8. Go back to your `EC2 Dashboard`
9. The box is booting. Once it's up you can log into it via SSH. Select your box and hit `connect` in the top left.  
![Pic 7](http://i.imgur.com/o0QqGBD.png)
10. Navigate to the same directory you put your `.pem` file and login as instructed. 
11. Before ssh'ing you need to run `chmod 400 your_key.pem` to make sure only you have access to the private key, otherwise AWS will yell at you.
Then you can type something like: 
	
		ssh -i your_key.pem ubuntu@ec2-xx-xxx-xxx-xxx.compute-1.amazonaws.com

11. Once you're in, run all of these. You might get away with copy and pasting the whole block, but I'd run each of these by themselves and watch for errors!

		sudo apt-get update
		sudo apt-get install git
		sudo apt-get install make 
		sudo apt-get install openjdk-7-jdk
		git clone https://github.com/EECS485/hadoop-example.git

12. `cd hadoop-example/mysrc` and run `make`. If that works you should be able to run `./invIndexTest.sh` and when it finishes type `cat output/*` to see the result!

13. Now you're on your own. Good luck!

Be sure to shut off your machine when you're not using it! Amazon will bill 
you for instance hours whenever your box is running! If you've created 
a new account, you can keep a micro instance running for 1 year. BUT, 
don't forget about it because they're not going to remind you when your 
trial is over!

Overall learning to use all of the nifty AWS gadgets is very rewarding. If you're feeling incredibly adventurous, Amazon offers `Elastic Map Reduce`. This service is really cool, and will let you spin up a cluster of machines to run your Hadoop job - and remember Hadoop was built for lots and lots of machines! It's sorta tough to work with and has a lot of add-on features we don't discuss. But if Hadoop, and distributed computing interest you, I'd recommend at least playing around with it. I'd offer some serious hacker-kudos if you're able to get your Project6 indexer to run on here - though you may have to do things a lot differently and rewrite some of our provided code. So do your regular version first and then port it over!

Have fun!

Feel free to contact Otto (ottosipe@umich.edu) if you run into problems!

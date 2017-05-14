---
layout: post
title: "Debugging Node.js"
toc: true
description: "In this article, you'll read about how to debug node.js applications on your local machine or from a remote machine."
category: ["node.js", "i-have-control"]
tags: ["javascript", "node.js", "debugging"]
series: "I Have Control"
series_category: "i-have-control"
series_no: 1
image: "https://nodejs.org/static/images/logos/nodejs.png"
---
{% include JB/setup %}

{% include series.html %}

<br />

We got a node.js application here and we've got source codes, but we can't figure it out the problems and bugs occur. We need to examine those, but how? Debugging comes into play.

<!--more-->

![](/assets/images/kitten.png)

Poor developer comes within a debugger attached. One has to debug her code at least once to make it work. It is a miracle if it works at the first run.

This method is extremely unproductive and makes our most needed brain cells vanished. Although, mostly because we don't know how to deal the other way, we must use it when we **actually need it**. For who seeks different approaches can visit my [Unit Testing](/en/software/2015/11/15/software-testing#unit-testing) article.

# Local Debugging

As we are here in the necessarily debugging zone, Nothing can save us except a debugger.

I seperated this topic into two: **Local** and **remote** debugging:

Local debugging means, you debug working code which works on your computer. On the other hand debugging working code on another machine is **remote debugging**: I'll mention that subject later.

We will see how we can debug node.js application and we will use [node-inspector](https://github.com/node-inspector/node-inspector) in this article.

To setup and use:

~~~
npm install -g node-inspector
node-debug app.js
~~~

> Note: node-inspector only supported with Chrome and Opera browsers

when node-debug runs, it will open <http://127.0.0.1:8080/debug?port=5858>  automatically on your default browser.

*node-debug* is a bunch of helpful tools collected to make easier local debugging. If we look what it does:

1. It runs node with --debug-brk parameter (to put and stop on a breakpoint on the first line and listen on port 5858)
1. It runs node-inspector on port 8080
1. It starts debugging on your default browser

Also much much more features at: <https://github.com/node-inspector/node-inspector#features>

# Remote debugging

Now we'll see how to debug on our machine a code which runs on another machine. For example we would like to have a look how the code runs on specific environments.

I'll do the demo on **vagrant** which I wrote about it before: (see: [Vagrant? wtf!?](/en/virtual-machines/2015/11/14/vagrant))

Lets see how we can debug the project on above link:

~~~
vagrant up
vagrant ssh
# --> go to related project directory (chatcat?)
grunt dev
~~~

We start the virtual machine and connect through ssh and open the project directory. After that we run the application on that machine. (I'd already wrote about how to use **grunt** to build and run our code with examples before)

On our previous [Multiroom Chat](/en/node.js/2015/11/15/multi-room-chat-application) application, we used **nodemon**. Make sure the directives on *GruntFile.js* script to be like this:

~~~js
nodemon: {
  dev: {
    script: 'app.js',
    options: {
      nodeArgs: ['--debug-brk'],
      watch: [
        'app.js',
        'Gruntfile.js',
        'src/**/*.js'
      ]
    }
  }
}
~~~

Secondly, we need to connect the same machine on another terminal using `vagrant ssh` to run `node-inspector`.

It will tell us to `Visit http://127.0.0.1:8080/?ws=127.0.0.1:8080&port=5858 to start debugging.` What an arrogance! But he don't know we are on an VM and we don't have any visual tools like browsers.

Fortunately our topic was **remote debugging** so we can debug on our machine with our familiar every day tools. But we need those **8080** and **5858** ports he said to us and they are important because we need to define them for **port forwarding** (see vagrant article):

**VagrantFile:**

~~~
...
config.vm.network "forwarded_port", guest: 3000, host: 3000
config.vm.network "forwarded_port", guest: 8080, host: 8080
config.vm.network "forwarded_port", guest: 5858, host: 5858
...
~~~

We forwarded all needed port to our machine but we need to re-open VM if it is already working.

* Exit application using `CTRL+C`.
* Type `exit` to exit *ssh* connection.
* To reload changed settings type `vagrant reload` and VM will close and open itself.
* Reconnect with `vagrant ssh`.
* Go to the related application's folder and type `grunt dev` to make *nodemon* run wirh --debug-brk parameter.
* Open another terminal window to connect using *ssh* and run `node-inspector` in it to be able to get debug information.
* Open on your own machine the given URL. (It will be <http://127.0.0.1:8080/debug?port=5858> if you didn't change any settings.)

Thats all folks! See you another time.

{% include series.html %}
<br />

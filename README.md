The app is a simple chat service that runs on Mojolicious real-time web framework

Original code and explanation:

https://github.com/kraih/mojo/wiki/Writing-websocket-chat-using-Mojolicious-Lite#___top

Before running the test edit t/chat.t file and look for $cant. That is the amount of open websockets that you will get. In my system $cant = 200 works ok.

Then run

> ./chat.pl test
  
and see if it passes or not

There are some tweaks you can do, depending on your operating system, I'm currently investigating this.

For ubuntu, you have to know how many file descriptors can handle a process. You can check that with

> ulimit -n

If you have the rights, you could change that to

> ulimit -n=65536

But normally ubuntu will not allow to do that, and will reject sudo ulimit so you will need to edit
file /etc/security/limits.conf:

> sudo vi /etc/security/limits.conf

and add folowing lines:

> youruser soft nofile 65536
> youruser hard nofile 65536

wher youruser is your user name. If you want that limit to be valid for all users, use * instead. If you want
that limit be valid for root also, you will have to add specific lines for  that, as root is not part of *.

Further information in: http://stackoverflow.com/questions/21515463/how-to-increase-maximum-file-open-limit-ulimit-in-ubuntu







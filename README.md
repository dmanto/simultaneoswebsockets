The app is a simple chat service that runs on Mojolicious real-time web framework

Original code and explanation:

https://github.com/kraih/mojo/wiki/Writing-websocket-chat-using-Mojolicious-Lite#___top

Before running the test edit t/chat.t file and look for $cant. That is the amount of open websockets that you will get. In my system $cant = 200 works ok.

Then run

  ./chat.pl test
  
and see if it passes or not

There are some tweaks you can do, depending on your operating system, I'm currently investigating this


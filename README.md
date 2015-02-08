# ht-menulet

A home theatre menulet to control devices over REST APIs.

Since my blu-ray player (OPPO) came with an app to control it, I figured It would be
easy to reverse engineer the communication and be able to control it from my mac
instead of my phone.

I set up a proxy on my laptop, configured my phone to use it, and used tcpdump
to sniff all the HTTP calls the app was making. Realizing it was using a
REST-like API, it was very easy to imitate.

For example, one of the calls was:

    GET /sendremotekey?%7B%22key%22%3A%22RET%22%7D HTTP/1.1

Which curl can easily do:

    curl -G 10.0.0.49:436/sendremotekey --data-urlencode {\"key\":\"OPEN\"}

And the tray opens! And then it was a simple google search to get all the
possible
[commands](http://download.oppodigital.com/BDP103/BDP103_RS232_Protocol_v1.2.1.pdf
). From there, I decided to build a menulet that will let me control the device
with my own interface.

The code is written in a modular fashion to allow extensions to other devices. A
long term goal includes integrating with a raspberry pi that would has an IR
transciever to allow controlling every device with a remote.

I later discovered that the Roku has a similar interface and I could reverse
engineer it as well. This portion is not yet complete but has the groundwork for
it. For example, here's a sample program that will send the Roku the letters you
write:

```shell
#/bin/bash

MyString=$1
echo $MyString | awk -v ORS="" '{ gsub(/./,"&\n") ; print }' | \ 
while read char
do
  curl -X POST 192.168.1.14:8060/keypress/Lit_$char
done
```


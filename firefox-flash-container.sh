#! /bin/bash

# Run Firefox with the Adobe Flash plugin in a Docker container and serve it to the screen with Xpra.

# Docker image: docker pull beli/firefox-flash

# Source code for container(s):
#    https://bitbucket.org/beli-sk/docker-firefox/src
#    https://hub.docker.com/r/beli/firefox-flash/

# ruby is also recommended as it is used to generate a random, unused port number for xpra

DOCKER_IMAGE="beli/firefox-flash"

if [[ -z $( type -P "xpra" ) ]] ; then
    echo "Xpra is required for $0 to work.  https://xpra.org/"
    echo "It is also available in homebrew (mac):  "
    echo "      brew install homebrew/cask/xpra"
    echo "or in various unix repos: "
    echo "      apt-get install xpra    # ... or ..."
    echo "      yum install xpra "
    exit 0
fi

[[ $( type -P "ruby" ) ]]  &&

    OPENPORT=$(ruby -e 'require "socket"; puts Addrinfo.tcp("", 0).bind {|s| s.local_address.ip_port }') ||
	OPENPORT=53142

COMMAND="xpra attach tcp:localhost:$OPENPORT"

echo "Opening xpra on port $OPENPORT.  If you detach from the session with (ctrl-c),"
echo "    run this command to resume:"
echo ""
echo "    $COMMAND"

docker pull $DOCKER_IMAGE &&
    docker run -d -p 127.0.0.1:$OPENPORT:10000 --rm $DOCKER_IMAGE &&
    $COMMAND

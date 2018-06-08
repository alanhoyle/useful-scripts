#! /bin/env bash
# Run Firefox with the Adobe Flash plugin in a Docker container and serve it to the screen with Xpra.

# Docker image: docker pull beli/firefox-flash

# Source code:
# https://bitbucket.org/beli-sk/docker-firefox/src
# https://hub.docker.com/r/beli/firefox-flash/

# also need to install xpra:
#      https://xpra.org/
#   also available in homebrew:  brew install homebrew/cask/xpra
#   in various unix repos: apt-get install xpra

# ruby is also recommended as it is used to generate a random, unused port number for xpra

[[ $( type -P "ruby" ) ]]  &&

    OPENPORT=$(ruby -e 'require "socket"; puts Addrinfo.tcp("", 0).bind {|s| s.local_address.ip_port }') ||
	OPENPORT=53142

COMMAND="xpra attach tcp:localhost:$OPENPORT"

echo "Opening xpra on port $OPENPORT.  If you detach from the session with (ctrl-c),"
echo "    run this command to resume:"
echo ""
echo "    $COMMAND"

docker run -d -p 127.0.0.1:$OPENPORT:10000 --rm beli/firefox-flash

$COMMAND

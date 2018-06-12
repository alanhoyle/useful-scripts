sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,volname=REMOTEPATH USERNAME@remote.example.com:/remotepath /remotepath

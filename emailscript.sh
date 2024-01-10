#/bin/bash

# this will be a file to test the email automation when the node went down
to="tanboont9801@uwec.edu"
from="tanboont9801@uwec.edu"


./heredoc-cleanup.sh | mailx -s "List of down node" tanboont9801@uwec.edu

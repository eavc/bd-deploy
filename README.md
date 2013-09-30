BeatDiabet.es server deployment setup.
======================================

Usage
-----

`mymachine$ ansible-playbook -v -i hosts.ini bd-landing-deploy.yml --ask-pass --sudo --limit @/home/cypher/bd-landing-deploy.retry`


Other useful incantations
-------------------------

`rsync -avzh --progress --del --rsh='ssh -p $PORTNUM' /location/of/source/ demo@remotemachine:/destination/server/public_html`



Copyright 2013 [BeatDiabet.es](http://beatdiabet.es/). All rights reserved.

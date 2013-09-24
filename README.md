BeatDiabet.es server deployment setup.
======================================

Usage
-----

`mymachine ~/5minbootstrap$ ansible-playbook -i hosts.ini bootstrap.yml --user deploy --ask-pass`

`mymachine$ ansible-playbook -v -i hosts.ini bd-landing-deploy.yml --ask-pass --sudo --limit @/home/cypher/bd-landing-deploy.retry`

Copyright 2013 [BeatDiabet.es](http://beatdiabet.es/). All rights reserved.

#!/bin/bash
sleep 5

echo "Launching nginx"
nginx -c /etc/nginx.conf

bash -c 'sleep 5; cd /learninglocker; node cli/dist/server createSiteAdmin admin@company.com Admin 4dmintest' &

echo "Launching Learning Locker"
cd /learninglocker
node ui/dist/server &
node api/dist/server &
node worker/dist/server &

echo "Launching Learning Locker xAPI"
cd /xapi
node dist/server.js


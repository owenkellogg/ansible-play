#!/bin/bash

BASEDIR=/var/log/rippled
sleep $[ ( $RANDOM % 60 )  + 1 ]s

NOW=`/bin/date -Iseconds`

mv $BASEDIR/debug.log $BASEDIR/debug.log.$NOW
cd /etc/rippled
/usr/sbin/rippled logrotate > /dev/null 2>&1
if `/usr/bin/ionice -c 3 /bin/gzip -c $BASEDIR/debug.log.$NOW > $BASEDIR/debug.log.$NOW.gz`
then
    /usr/bin/ionice -c 3 /bin/rm $BASEDIR/debug.log.$NOW
fi
/usr/bin/find $BASEDIR -name '*.gz' -mtime +45 -exec /bin/rm {} \;
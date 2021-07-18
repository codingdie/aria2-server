#!/bin/bash
sed -i "s/rpc-secret=123456/rpc-secret=$ARIA2_SECRET/g" /root/aria2.conf
echo "default aria2 rpc: $ARIA2_HOST:$ARIA2_PORT, secret:$ARIA2_SECRET"
ARIA2_SECRET_BASE_64=`echo -n $ARIA2_SECRET | base64`
sed -i "s/6800/$ARIA2_PORT/g" /root/www/js/aria-ng-2d4f618b32.min.js
sed -i "s/rpcHost:\"\"/rpcHost:\"$ARIA2_HOST\"/g" /root/www/js/aria-ng-2d4f618b32.min.js
sed -i "s/secret:\"\"/secret:\"$ARIA2_SECRET_BASE_64\"/g" /root/www/js/aria-ng-2d4f618b32.min.js

trackers=`curl -s https://ngosang.github.io/trackerslist/trackers_all_ip.txt|grep -v '^$' |paste -s -d ","`;
echo "bt-tracker=$trackers" >>  /root/aria2.conf
cat /root/aria2.conf
if [ "$ENABLE_ARIA2_WEB" = "true" ];then
    nginx
fi
exec aria2c --conf-path="/root/aria2.conf"

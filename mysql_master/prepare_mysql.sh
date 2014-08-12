#!/bin/bash
mysqld_get_param() {
	/usr/sbin/mysqld --print-defaults \
		| tr " " "\n" \
		| grep -- "--$1" \
		| tail -n 1 \
		| cut -d= -f2
}

mysqld_status () {
    MYADMIN="mysqladmin"

    ping_output=`$MYADMIN ping 2>&1`; ping_alive=$(( ! $? ))
    ps_alive=0
    pidfile=`mysqld_get_param pid-file`

    if [ -f "$pidfile" ] && ps `cat $pidfile` >/dev/null 2>&1; then ps_alive=1; fi
    
    if [ "$1" = "check_alive"  -a  $ping_alive = 1 ] ||
       [ "$1" = "check_dead"   -a  $ping_alive = 0  -a  $ps_alive = 0 ]; then
    	return 0 # EXIT_SUCCESS
    else
      	return 1 # EXIT_FAILURE
    fi
}

echo "==== install mysql db files ===="
mysql_install_db

echo "==== run mysqld_safe ===="
mysqld_safe > /dev/null 2>&1 &

MYSQLD_STARTUP_TIMEOUT=20
for i in `seq 1 "${MYSQLD_STARTUP_TIMEOUT}"`; do
    sleep 1

    if mysqld_status check_alive;
    then
        break
    fi

    echo -n "."
done
echo ""

if mysqld_status check_dead;
then
    echo "!!!! launching mysqld failured... !!!!"
    tail /var/log/mysql/error.log
    exit -1
fi

echo "==== launch mysql ===="
echo "==== change root user and add repl user ===="
echo "use mysql; TRUNCATE TABLE user;" | mysql -hlocalhost -uroot
echo "GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'root';"    | mysql -hlocalhost -uroot
echo "GRANT REPLICATION SLAVE ON *.* TO repl@'%' IDENTIFIED BY 'repl';" | mysql -hlocalhost -uroot

echo "====== create mysql_dir complete! ======"

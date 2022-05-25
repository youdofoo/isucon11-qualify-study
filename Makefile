NGINX_LOG=/var/log/nginx/access.log
MATCHING=""
FIELDS=count,method,uri,min,max,sum,avg,p99
alp:
	alp ltsv --file ${NGINX_LOG} -m ${MATCHING} -s sum --reverse

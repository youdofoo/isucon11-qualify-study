NGINX_LOG=/var/log/nginx/access.log
MATCHING="/api/isu/[^/]+/icon","/assets/.+\.(js|svg|css)","/api/isu/[^/]+","/api/isu/[^/]+/graph","/api/condition/[^/]+","/isu/[^/]+","/isu/[^/]+/condition","/isu/[^/]+/graph"
FIELDS=count,2xx,3xx,5xx,method,uri,min,max,sum,avg,p99

.PHONY: alp
alp:
	sudo alp ltsv --file ${NGINX_LOG} -m ${MATCHING} -o ${FIELDS} --sort sum --reverse


SQ_LOG=/var/log/mysql/mariadb-slow.log
.PHONY: pt
pt:
	sudo pt-query-digest ${SQ_LOG}

.PHONY: slow
slow:
	sudo mysqldumpslow -s t | head -n 20

.PHONY: install-alp
install-alp:
	wget https://github.com/tkuchiki/alp/releases/download/v1.0.8/alp_linux_amd64.zip \
	&& sudo unzip alp_linux_amd64.zip -d /usr/local/bin \
	&& sudo chmod 755 /usr/local/bin


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

.PHONY: build
build:
	cd go && go build -o isucondition main.go

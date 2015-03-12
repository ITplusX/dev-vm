mariadb-server:
  pkg:
    - installed
    - name: mariadb-server
  service:
    - running
    - name: mariadb
    - require:
      - pkg: mariadb-server

mariadb:
  pkg:
    - installed
    - name: mariadb

#	/etc/mysql/my.cnf:
#	  file:
#	    - managed
#	    - source: salt://states/mysql/etc/mysql/my.cnf
#	    - mode: 644
#	    - require:
#	        - pkg: mysql-server
#	    - defaults:
#	        port: 3306
#	        bind_address: 127.0.0.1
#	
#	/etc/mysql/conf.d:
#	  file:
#	    - directory
#	    - dir_mode: 0755
#	    - mode: 0644
#	
#	/etc/mysql/conf.d/server-encoding-and-collation.cnf:
#	  file:
#	    - managed
#	    - mode: 0644
#	    - source: salt://states/mysql/etc/mysql/conf.d/server-encoding-and-collation.cnf
#	    - require:
#	      - pkg: mysql-server
#	    - watch_in:
#	      - service: mysql-server
#	    - require_in:
#	      - file: /etc/mysql/conf.d
#	
#	/etc/mysql/conf.d/default-table-engine.cnf:
#	  file:
#	    - managed
#	    - mode: 0644
#	    - source: salt://states/mysql/etc/mysql/conf.d/default-table-engine.cnf
#	    - require:
#	      - pkg: mysql-server
#	    - watch_in:
#	      - service: mysql-server
#	    - require_in:
#	      - file: /etc/mysql/conf.d
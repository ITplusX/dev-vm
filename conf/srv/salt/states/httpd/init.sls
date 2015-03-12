httpd:
  pkg:
    - installed
  service:
    - name: httpd
    - running
    - reload: True
    - watch:
      - file: /etc/httpd/conf/httpd.conf
    - require:
      - pkg: httpd

/etc/httpd/conf/httpd.conf:
  file.managed:
    - source: salt://states/httpd/etc/httpd/conf/httpd.conf

vhost_http:
  file:
    - managed
    - source: salt://states/httpd/etc/httpd/conf.d/virtual-host-80.conf
    - name: /etc/httpd/conf.d/virtual-host-80.conf
    - user: root
    - group: root
    - file_mode: 644
    - defaults:
       doc_root: /vagrant/htdocs
    - require:
      - pkg: httpd

# httpd-php-packages:
#     pkg:
#         - installed
#         - names:
#             - libhttpd-mod-php5

# a2enmod_rewrite:
#     cmd:
#         - name: a2enmod rewrite
#         - run
#         - require:
#             - pkg: httpd
#         - require_in:
#             - service: httpd


# extend:
#   httpd:
#     service:
#       - running
#       - watch:
#         - file: /etc/httpd/conf.d/virtual-host-80.conf
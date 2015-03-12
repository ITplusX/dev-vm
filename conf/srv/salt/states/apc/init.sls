php-apc:
  pkg:
    - installed
  require:
    - pkg: php5

apc.ini:
  file:
    - managed
    - source: salt://states/apc/etc/php5/conf.d/apc.ini
    - name: /etc/php5/conf.d/apc.ini
    - user: root
    - group: root
    - mode: 644
    - defaults:
       memory: 32
    - require:
      - pkg: php-apc

extend:
  apache2:
    service:
      - running
      - watch:
        - pkg: php-apc
        - file: apc.ini

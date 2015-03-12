php5:
  pkg:
  - installed
  - pkgs:
    - php5
    - php5-mysql
    - php5-cli
    - php5-dev
    - php5-gd
    - php5-curl
    - php-pear
    - php5-mcrypt
    - php5-intl
#    - php5-xdebug
  - require:
    - pkg: apache2
    - pkg: mysql-server

set_pear_auto_discover:
    cmd:
        - run
        - name: 'pear config-set auto_discover 1'
        - cwd: /home/vagrant
        - unless: test -e /usr/bin/phpunit
        - require:
            - pkg: php5

install_phpqatools:
    cmd:
        - run
        - name: 'pear install pear.phpqatools.org/phpqatools'
        - cwd: /home/vagrant
        - unless: test -e /usr/bin/phpunit
        - require:
            - cmd: set_pear_auto_discover

/etc/php5/apache2/php.ini:
  file.managed:
    - source: salt://states/php5/etc/php5/apache2/php.ini

/etc/php5/cli/php.ini:
  file.managed:
    - source: salt://states/php5/etc/php5/cli/php.ini

#/etc/php5/conf.d/xdebug.ini:
#  file:
#    - managed
#    - source: salt://states/php5/etc/php5/conf.d/xdebug.ini
#    - mode: 644
#    - require:
#      - pkg: php5
#
#extend:
#  apache2:
#    service:
#      - running
#      - watch:
#        - file: /etc/php5/conf.d/xdebug.ini

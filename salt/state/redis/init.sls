redis_ppa:
  pkgrepo.managed:
    - ppa: chris-lea/redis-server

redis-server:
  pkg:
    - installed
    - require:
      - pkgrepo: redis_ppa
  service:
    - running
    - watch:
      - pkg: redis-server
      - file: /etc/redis/redis.conf

/etc/redis/redis.conf:
  file.managed:
    - template: jinja
    - source: salt://redis/redis.conf.j2
    - require:
      - pkg: redis-server

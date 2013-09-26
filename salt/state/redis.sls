redis_ppa:
  pkgrepo.managed:
    - ppa: chris-lea/redis-server

redis-server:
  pkg:
    - installed
  service:
    - dead
    - enable: False

/etc/redis/redis.conf:
  file:
    - absent
    - require:
      - pkg: redis-server

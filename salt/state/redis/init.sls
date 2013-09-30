{% set redis = pillar.get('redis', {}) -%}
redis_native:
  pkgrepo.managed:
    - ppa: chris-lea/redis-server

  pkg.installed:
    - name: redis-server
    - require:
      - pkgrepo: redis_native

  service.dead:
    - name: redis-server
    - enable: False
    - require:
      - pkg: redis_native

redis_init:
  file.managed:
    - name: /etc/init/{{ redis.get('service', 'redis') }}.conf
    - source: salt://redis/upstart.conf.j2
    - template: jinja
    - require:
      - pkg: redis_native

redis_conf:
  file.managed:
    - name: /etc/redis/{{ redis.get('service', 'redis') }}.conf
    - source: salt://redis/redis.conf.j2
    - template: jinja
    - require:
      - pkg: redis_native

redis_service:
  service.running:
    - name: redis
    - enable: True
    - watch:
      - pkg: redis_native
      - file: redis_init
      - file: redis_conf

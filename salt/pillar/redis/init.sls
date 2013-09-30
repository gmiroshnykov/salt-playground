redis:
  service: redis
  options:
    daemonize: "yes"
    dir: /var/lib/redis
    pidfile: /var/run/redis/redis.pid
    loglevel: notice
    logfile: /var/log/redis/redis.log
    bind: 0.0.0.0
    port: 6379
    save: "60 1000"

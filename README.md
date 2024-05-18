# DB performance test 🗄️

A variety of tests against MySQL

## Requirements 🐳

- [Docker](https://docs.docker.com/engine/install/)
- [Make](https://www.tutorialspoint.com/unix_commands/make.htm) is installed (usually via `apt install build-essential`)
- [sysbench](https://github.com/akopytov/sysbench)

# Setup ⚙️

- Clone this repository
- Ensure `load.sh` has the appropriate permissions `chmod a+x load.sh`
- Run `make start`
- Run `make load`

The databases should now have [Employees Sample Database](https://dev.mysql.com/doc/employee/en/) loaded.


# Benchmarking 🚀


## MySQL 5.7.44

```bash
sysbench benchmark_read.lua --mysql-user=root --mysql-host=0.0.0.0 --mysql-port=3357 --mysql-password=password --mysql-db=employees --report-interval=5 --events=0 --time=10 run
```

## MySQL 8.0.36

```bash
sysbench benchmark_read.lua --mysql-user=root --mysql-host=0.0.0.0 --mysql-port=3380 --mysql-password=password --mysql-db=employees --report-interval=5 --events=0 --time=10 run
```

## PostgreSQL 16.3

```bash
sysbench benchmark_read.lua --postgres-user=root --postgres-host=0.0.0.0 --postgres-port=5432 --postgres-password=password --postgres-db=employees --report-interval=5 --events=0 --time=10 run
```

# DB performance test 🗄️

A variety of tests against MySQL

## Requirements 🐳

- [Docker](https://docs.docker.com/engine/install/)
- [sysbench](https://github.com/akopytov/sysbench)

# Setup ⚙️

- Clone this repository
- Ensure `db` has the appropriate permissions `chmod a+x db`
- Run `./db up`
- Run `./db init`

The databases should now have [Employees Sample Database](https://dev.mysql.com/doc/employee/en/) loaded.


# Benchmarking 🚀

To test with 2 JSON columns added to the table (`salaries`) with data, run `./db many_columns` then re-run the benchmarks

## MySQL 5.7.44

```bash
./db benchmark_mysql57_read
```

## MySQL 8.0.36

```bash
./db benchmark_mysql8_read
./db benchmark_mysql8_count
./db benchmark_mysql8_count_date_range
```

## PostgreSQL 16.3

```bash
./db benchmark_pgsql_read
```

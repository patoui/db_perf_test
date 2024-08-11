-- Called by sysbench one time to initialize this script
function thread_init()
    drv = sysbench.sql.driver()
    con = drv:connect()
end

-- Called by sysbench when script is done executing
function thread_done()
    con:disconnect()
end

-- Called by sysbench for each execution
function event()
    con:query("SELECT COUNT(*) FROM salaries WHERE from_date >= '1985-01-01' AND from_date < '1995-01-01'")
end

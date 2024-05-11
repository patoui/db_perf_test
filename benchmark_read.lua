-- Called by sysbench one time to initialize this script
function thread_init()

    -- Create globals to be used elsewhere in the script

    -- drv - initialize the sysbench mysql driver
    drv = sysbench.sql.driver()

    -- con - represents the connection to MySQL
    con = drv:connect()
end

-- Called by sysbench when script is done executing
function thread_done()
    -- Disconnect/close connection to MySQL
    con:disconnect()
end

-- Called by sysbench for each execution
function event()
    execute_selects()
end

local select_counts = {"SELECT COUNT(*) FROM employees.employees where gender = 'M'"}

function execute_selects()
    -- Execute each simple, no parameters, SELECT
    for i, o in ipairs(select_counts) do
        con:query(o)
    end
end

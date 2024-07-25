-- Called by sysbench one time to initialize this script
function thread_init()
    drv = sysbench.sql.driver()
    con = drv:connect()
end

function prepare()
    -- local drv = sysbench.sql.driver()
    -- local con = drv:connect()

    -- con:query("BEGIN")

    -- causing implicit commit, and making the next func call fail
    -- run_sql_file(con, "data/init_" .. drv:name() .. ".sql")
    -- load_tsv(con, "data/departments.tsv")

    -- con:query("COMMIT")
end

-- Called by sysbench when script is done executing
function thread_done()
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

function cleanup()
    local drv = sysbench.sql.driver()
    local con = drv:connect()
    local tables = {"salaries", "titles", "dept_manager", "dept_emp", "departments", "employees"}

    for k, table in pairs(tables) do
        con:query("DROP TABLE IF EXISTS " .. table)
    end
end

function read_file(filename)
    local file = assert(io.open(filename, "r"))
    local content = file:read("*all")
    file:close()

    return content
end

function run_sql_file(con, filename)
    print("running SQL file: " .. filename)

    sql = read_file(filename)

    local res, err = con:query(sql)
    if not res then
        print("Error while executing SQL file", err)
    else
        print("Successfully executed SQL file")
    end
end

function split(str, sep)
    local fields = {}
    local pattern = string.format("([^%s]+)", sep)
    string.gsub(str, pattern, function(c) fields[#fields + 1] = c end)
    return fields
end

function load_tsv(con, filename)
    local file = io.open(filename, "r")
    if not file then
        print("Could not open file: " .. filename)
        return
    end

    local table_name = filename:match("data/(.+)%..+")
    -- local cols = ""
    local needs_columns = true
    local insert_statement = "";

    for line in file:lines() do
        if line ~= nil then
            local fields = split(line, '\t')

            if needs_columns then
                -- cols = table.concat(fields, ", "):gsub(",%s*$", "")
                needs_columns = false

                insert_statement = string.format(
                    "INSERT INTO %s (%s) VALUES ",
                    table_name,
                    table.concat(fields, ", "):gsub(",%s*$", "")
                )
            else
                -- local insert = string.format(
                --     "INSERT INTO %s (%s) VALUES (%s)",
                --     table_name,
                --     cols,
                --     "'" .. table.concat(fields, "', '"):gsub(",%s'*$", "") .. "'"
                -- )
                -- local res, err = con:query(insert)

                -- append values for bulk insert
                insert_statement = insert_statement .. string.format(
                    "(%s),",
                    "'" .. table.concat(fields, "', '"):gsub(",%s'*$", "") .. "'"
                )
            end
        end
    end

    file:close()

    print("\n\n" .. insert_statement:gsub(",'*$", "") .. "\n\n")

    con:query(insert_statement:gsub(",'*$", ""))

end

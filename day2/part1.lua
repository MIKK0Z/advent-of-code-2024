INPUT_PATH = "./input"

local function printf(format, ...)
    io.write(string.format(format, ...))
end

local file = io.open(INPUT_PATH, "r")
if not file then
    printf("Could not open file: %s\n", INPUT_PATH)
    return
end

local content = file:read("a")
file:close()

local lines = string.gmatch(content, "[^\n]+")

local safe_reports = 0
for line in lines do
    local direction = 0
    local levels = {}
    for level in string.gmatch(line, "[^%s]+") do 
        table.insert(levels, level)
    end

    for i, level in ipairs(levels) do
        if i == 1 then
            if tonumber(levels[2]) < tonumber(level) then
                direction = -1
            else
                direction = 1
            end
        else
            local delta = (tonumber(level) - tonumber(levels[i - 1])) * direction
            if delta < 1 or delta > 3 then
                goto continue_outer
            end
        end
    end

    safe_reports = safe_reports + 1
    ::continue_outer::
end

printf("safe reports: %d\n", safe_reports)
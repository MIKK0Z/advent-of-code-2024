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

local function getDelta(level1, level2, direction)
    return (tonumber(level1) - tonumber(level2)) * direction
end

local function isDeltaOk(delta)
    return delta > 0 and delta < 4
end

local function parseLine(levels)
    local direction = 0

    if tonumber(levels[2]) < tonumber(levels[1]) then
        direction = -1
    else
        direction = 1
    end

    for i, _ in ipairs(levels) do
        if i ~= 1 then 
            local delta = getDelta(levels[i], levels[i - 1], direction)
            if not isDeltaOk(delta) then 
                return false
            end
        end
    end

    return true
end

local safe_reports = 0
for line in lines do
    local levels = {}
    for level in string.gmatch(line, "[^%s]+") do 
        table.insert(levels, level)
    end

    local isNoErrors = parseLine(levels)
    if not isNoErrors then
        for i, _ in ipairs(levels) do
            local levelsWithoutThisIndex = {}
            for j, value in ipairs(levels) do
                if i ~= j then
                    table.insert(levelsWithoutThisIndex, value)
                end
            end

            if parseLine(levelsWithoutThisIndex) then
                safe_reports = safe_reports + 1
                goto break_out
            end
        end
    else
        safe_reports = safe_reports + 1
    end

    ::break_out::
end

printf("safe reports: %d\n", safe_reports)
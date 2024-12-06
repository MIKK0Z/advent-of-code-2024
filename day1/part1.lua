INPUT_PATH = "./input"

local function printf(format, ...)
    io.write(string.format(format, ...))
end

local function compare(a, b)
    return a < b
end

local file = io.open(INPUT_PATH, "r")
if not file then
    printf("Could not open file: %s\n", INPUT_PATH)
    return
end

local content = file:read("a")
file:close()

local lines = string.gmatch(content, "[^\n]+")
local left_numbers = {}
local right_numbers = {}
for line in lines do
    local left, right = string.match(line, "(%d+)%s+(%d+)")
    table.insert(left_numbers, tonumber(left))
    table.insert(right_numbers, tonumber(right))
end

table.sort(left_numbers, compare)
table.sort(right_numbers, compare)

local diff = 0
for i, value in ipairs(left_numbers) do
    diff = diff + math.abs(value - right_numbers[i])
end

printf("difference: %d\n", diff)
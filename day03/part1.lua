INPUT_PATH = "./input_example"

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

local sum = 0
local enabled = true
local uncorruptedData = string.gmatch(content, "mul%(%d+,%d+%)")

for multiplication in uncorruptedData do

    local first, second = string.match(multiplication, "mul%((%d+),(%d+)%)")
    if enabled then
        sum = sum + tonumber(first) * tonumber(second)
    end
end

printf("sum: %d\n", sum)
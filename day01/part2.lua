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
local left_numbers = {}
local right_numbers = {}
for line in lines do
    local left, right = string.match(line, "(%d+)%s+(%d+)")
    table.insert(left_numbers, tonumber(left))
    table.insert(right_numbers, tonumber(right))
end

local function countHowMany(arr, lookedForNumber)
    local instances = 0
    for _, value in ipairs(arr) do
        if value == lookedForNumber then
            instances = instances + 1
        end
    end

    return instances
end

local similarity = 0
for _, value in ipairs(left_numbers) do
    similarity = similarity + value * countHowMany(right_numbers, value)
end

printf("similarity: %d\n", similarity)
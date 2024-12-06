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

local sum = 0
local enabled = true

for i = 1, #content do
    if content:sub(i, i) == 'd' then
        if content:sub(i, i + 3) == "do()" then
            enabled = true
            i = i + 4
            goto continue
        end

        if content:sub(i, i + 6) == "don't()" then
            enabled = false
            i = i + 7
            goto continue
        end
    end

    if enabled then
        if content:sub(i, i + 3) == "mul(" then
            local parsedMul = string.match(content:sub(i), "^mul%(%d+,%d+%)")
            if parsedMul then
                local first, second = string.match(parsedMul, "mul%((%d+),(%d+)%)")
                sum = sum + (tonumber(first) * tonumber(second))
            end
        end
    end

    ::continue::
end

printf("sum: %d\n", sum)
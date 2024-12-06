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

local lines = {}
local lineLength = 0
local lineCount = 0
for line in string.gmatch(content, "[^\n]+") do
    if lineLength == 0 then
        lineLength = #line
    end

    table.insert(lines, line)
    lineCount = lineCount + 1
end

local function getCharAt(x, y)
    if y < 1 or y > lineCount then
        return nil
    end

    if x < 1 or x > lineLength then
        return nil
    end

    return lines[y]:sub(x, x)
end

local function checkUpward(x, y)
    return getCharAt(x, y - 1) == "M" and getCharAt(x, y - 2) == "A" and getCharAt(x, y - 3) == "S"
end

local function checkForward(x, y)
    return getCharAt(x + 1, y) == "M" and getCharAt(x + 2, y) == "A" and getCharAt(x + 3, y) == "S"    
end

local function checkDownward(x, y)
    return getCharAt(x, y + 1) == "M" and getCharAt(x, y + 2) == "A" and getCharAt(x, y + 3) == "S"
end

local function checkBackward(x, y)
    return getCharAt(x - 1, y) == "M" and getCharAt(x - 2, y) == "A" and getCharAt(x - 3, y) == "S"
end

local function checkUpRight(x, y)
    return getCharAt(x + 1, y - 1) == "M" and getCharAt(x + 2, y - 2) == "A" and getCharAt(x + 3, y - 3) == "S"
end

local function checkDownRight(x, y)
    return getCharAt(x + 1, y + 1) == "M" and getCharAt(x + 2, y + 2) == "A" and getCharAt(x + 3, y + 3) == "S"
end

local function checkDownLeft(x, y)
    return getCharAt(x - 1, y + 1) == "M" and getCharAt(x - 2, y + 2) == "A" and getCharAt(x - 3, y + 3) == "S"
end

local function checkUpLeft(x, y)
    return getCharAt(x - 1, y - 1) == "M" and getCharAt(x - 2, y - 2) == "A" and getCharAt(x - 3, y - 3) == "S"
end

local xmases = 0
for y, line in ipairs(lines) do
    for x = 1, #line do
        local char = line:sub(x, x)
        if char == "X" then
            if checkUpward(x, y) then
                xmases = xmases + 1
                printf("Found XMAS at (%d, %d) (upward)\n", x, y)
            end

            if checkForward(x, y) then
                xmases = xmases + 1
                printf("Found XMAS at (%d, %d) (forward)\n", x, y)
            end

            if checkDownward(x, y) then
                xmases = xmases + 1
                printf("Found XMAS at (%d, %d) (downward)\n", x, y)
            end

            if checkBackward(x, y) then
                xmases = xmases + 1
                printf("Found XMAS at (%d, %d) (backward)\n", x, y)
            end

            if checkUpRight(x, y) then
                xmases = xmases + 1
                printf("Found XMAS at (%d, %d) (up-right)\n", x, y)
            end

            if checkDownRight(x, y) then
                xmases = xmases + 1
                printf("Found XMAS at (%d, %d) (down-right)\n", x, y)
            end

            if checkDownLeft(x, y) then
                xmases = xmases + 1
                printf("Found XMAS at (%d, %d) (down-left)\n", x, y)
            end

            if checkUpLeft(x, y) then
                xmases = xmases + 1
                printf("Found XMAS at (%d, %d) (up-left)\n", x, y)
            end
        end
    end
end

printf("xmases: %d\n", xmases)
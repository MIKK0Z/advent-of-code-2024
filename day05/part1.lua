INPUT_PATH = "./input-example"

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

local cantBeAfter = {}
local updates = {}

local appendToRules = true

for line in content:gmatch("[^\n]*") do
    if line == "" then
        appendToRules = false
        goto continue
    end
    
    if appendToRules then
        local value, key = line:match("(%d+)|(%d+)")
    
        if cantBeAfter[key] == nil then
            cantBeAfter[key] = { [value] = true}
        else
            cantBeAfter[key][value] = true
        end
    else
        local update = {}
        for part in line:gmatch("[^,]+") do
            table.insert(update, part)
        end

        table.insert(updates, update)
    end

    ::continue::
end

local function parseUpdate(update)
    for i, page in ipairs(update) do
        if cantBeAfter[page] ~= nil then
            for _, next in ipairs({ table.unpack(update, i) }) do
                if cantBeAfter[page][next] then
                    return false
                end
            end
        end
    end

    return true
end

local sum = 0
for _, update in ipairs(updates) do

    if parseUpdate(update) then
        sum = sum + update[(#update + 1) / 2]
    end
end


printf("sum: %d\n", sum)
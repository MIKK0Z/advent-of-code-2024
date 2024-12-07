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
    for pageIndex, page in ipairs(update) do
        if cantBeAfter[page] ~= nil then
            for nextIndex, next in ipairs({ table.unpack(update, pageIndex) }) do
                if cantBeAfter[page][next] then
                    return false, pageIndex, nextIndex + pageIndex - 1, next
                end
            end
        end
    end

    return true, 0, 0, ""
end

local sum = 0
for _, update in ipairs(updates) do
    local add = false
    while not parseUpdate(update) do
        local _, pageIndex, nextIndex, next = parseUpdate(update)

        table.remove(update, nextIndex)
        table.insert(update, pageIndex, next)
        
        add = true
    end


    if add then
        sum = sum + update[(#update + 1) / 2]
    end

end

printf("sum: %d\n", sum)
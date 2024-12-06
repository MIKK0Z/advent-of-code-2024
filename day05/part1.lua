INPUT_PATH = "./input-example"

local function printf(format, ...)
    io.write(string.format(format, ...))
end

local file = io.open(INPUT_PATH, "r")
if not file then
    printf("Could not open file: %s\n", INPUT_PATH)
    return
end

function dump(o)
    if type(o) == 'table' then
       local s = '{\n'
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '\t['..k..'] = ' .. dump(v) .. ',\n'
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end
 

local content = file:read("a")
file:close()

local rules = {}
local updates = {}

local appendToRules = true

for line in content:gmatch("[^\n]*") do
    if line == "" then
        appendToRules = false
        goto continue
    end
    
    if appendToRules then
        local rule = {}
        for part in line:gmatch("[^|]+") do
            table.insert(rule, part)
        end

        table.insert(rules, rule)
    else
        local update = {}
        for part in line:gmatch("[^,]+") do
            table.insert(update, part)
        end

        table.insert(updates, update)
    end

    ::continue::
end

for i, rule in ipairs(rules) do
    printf("rule %d: %s\n", i, dump(rule))
end

for i, update in ipairs(updates) do
    printf("update %d: %s\n", i, dump(update))
end
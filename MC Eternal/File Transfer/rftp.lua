local filesystem = require("filesystem")
local term = require("term")
local component = require("component")

local function termClear()
    term.clear()
    term.setCursor(1,1)
end
  
local function nextLine()
    local x,y = term.getCursor()
    term.setCursor(1,y+1)
end

local function interface()
    termClear()
    term.write("Remote File Transfer Protocol")
    nextLine()
    term.write("1. Send File")
    nextLine()
    term.write("2. Receive File")
    nextLine()
    term.write("Choice: ")
    local choice = tonumber(io.read())
    if (choice ~= 1 and choice ~= 2) then
        interface()
        return nil
    end
    if (choice == 1) then
        
    end
    if (choice == 2) then

    end
end

local function rftp()
    interface()
end

return rftp
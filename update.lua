local term = require("term")
local filesystem = require("filesystem")

local function termClear()
    term.clear()
    term.setCursor(1,1)
end

local function download(dpath, gpath)
    shell.execute("wget gpath dpath")

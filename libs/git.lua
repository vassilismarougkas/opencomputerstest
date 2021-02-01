local git = {}

local mainpath = "https://raw.githubusercontent.com/vassilismarougkas/opencomputerstest/master"

local function requireTemporary(gitpath)
    local shell = require("shell")
    local filesystem = require("filesystem")

    local i = 0
    repeat 
        i = i+1
    until not filesystem.exists(string.format("/temp/temp%d.lua",i))

    shell.execute(string.format("wget -q -f %s%s /temp/temp%d.lua", mainpath, gitpath, i))
    shell.setWorkingDirectory("/")
    return require(string.format("/temp/temp%d",i))
end

local function downloadTemporary(gitpath)
    local shell = require("shell")
    local filesystem = require("filesystem")

    local i = 0
    repeat 
        i = i+1
    until not filesystem.exists(string.format("/temp/temp%d.lua",i))

    shell.execute(string.format("wget -q -f %s%s /temp/temp%d.lua", mainpath, gitpath, i))
    return string.format("/temp/temp%d.lua",i)
end


git.tRequire = requireTemporary
git.tDownload = downloadTemporary
git.mainpath = mainpath


return git
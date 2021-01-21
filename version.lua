local version = 2.2

local files = {
    ["/bin/update.lua"] = "/update.lua",
    ["/data/version.lua"] = "/version.lua",
    ["/etc/motd"] = "/etc/motd.lua",
    ["/bin/info.lua"] = "/programs/info.lua"
}


local var = {}


local function getVersion()
    return version
end

local function getFiles()
    return files
end

var.getVersion = getVersion
var.getFiles = getFiles

return var
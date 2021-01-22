local version = 3.4

local files = {
    ["/bin/update.lua"] = "/update.lua",
    ["/data/version.lua"] = "/version.lua",
    ["/etc/motd"] = "/etc/motd.lua",
    ["/bin/info.lua"] = "/programs/info.lua",
    ["/lib/formatter.lua"] = "/libs/formatter.lua",
    ["/bin/transfer.lua"] = "/programs/transfer.lua",
    ["/bin/tar.lua"] = "/programs/tar.lua"
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
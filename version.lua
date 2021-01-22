local version = 4.1

local files = {
    ["/bin/update.lua"] = "/update.lua",
    ["/data/version.lua"] = "/version.lua",
    ["/etc/motd"] = "/etc/motd.lua",
    ["/bin/info.lua"] = "/programs/info.lua",
    ["/lib/formatter.lua"] = "/libs/formatter.lua",
    ["/bin/apt.lua"] = "/programs/apt.lua"
}

local extendedfiles = {
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

local function getExtendedFiles()
    return extendedfiles
end

var.getExtendedFiles = getExtendedFiles
var.getVersion = getVersion
var.getFiles = getFiles

return var
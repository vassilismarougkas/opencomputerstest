local version = 6.3

local files = {
    ["/bin/update.lua"] = "/update.lua",
    ["/data/version.lua"] = "/version.lua",
    ["/etc/motd"] = "/etc/motd.lua",
    ["/bin/info.lua"] = "/programs/info.lua",
    ["/lib/formatter.lua"] = "/libs/formatter.lua",
    ["/bin/apt.lua"] = "/programs/apt.lua",
    ["/bin/properties.lua"] = "/programs/properties.lua"
}

local extendedfiles = {
    ["/bin/transfer.lua"] = "/programs/transfer.lua",
    ["/bin/tar.lua"] = "/programs/tar.lua",
    ["/bin/oppm.lua"] = "/apt/programs/oppm/oppm.cfg",
    ["/etc/oppm.cfg"] = "/apt/programs/oppm/oppm.cfg",
    ["/etc/opdata.svd"] = "/apt/programs/oppm/opdata.svd"
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
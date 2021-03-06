return {
    ["tar"] = {["location"] = "/programs/tar.lua", ["save"] = "/bin/", ["name"] = "tar.lua",},
    ["transfer"] = {["location"] = "/programs/transfer.lua", ["save"] = "/bin/", ["name"] = "transfer.lua",["version"] = 1.1},
    ["oppm"] = {["location"] = "/apt/programs/oppm/oppm.lua", ["save"] = "/bin/", ["name"] = "oppm.lua", ["dependencies"] = {"oppm_config", "oppm_opdata"}},
    ["oppm_config"] = {["location"] = "/apt/programs/oppm/oppm.cfg", ["save"] = "/etc/", ["name"] = "oppm.cfg", ["hide"] = true},
    ["oppm_opdata"] = {["location"] = "/apt/programs/oppm/opdata.svd", ["save"] = "/etc/", ["name"] = "opdata.svd", ["hide"] = true},
    ["flashloader"] = {["location"] = "/apt/programs/flashloader/flashloader.lua", ["save"] = "/bin/", ["name"] = "flashloader.lua", ["version"] = 1.0},
    ["git"] = {["location"] = "/libs/git.lua", ["save"] = "/lib/", ["name"] = "git.lua", ["version"] = 1.0, ["hide"] = true},
    ["bundle"] = {["location"] = "/apt/programs/bundle.lua", ["save"] = "/etc/rc.d/", ["name"] = "bundle.lua"},
    ["cutils"] = {["location"] = "/apt/libraries/cutils.lua", ["save"] = "/lib/", ["name"] = "cutils.lua", ["version"] = 1.1},
    ["packman"] = {["location"] = "/packman/packman.lua", ["save"] = "/bin/", ["name"] = "packman.lua", ["dependencies"] = {"tar", "cutils"}}
}

-- default values:
--   Version: 1.0
--   dependencies: {}
--   hide: false
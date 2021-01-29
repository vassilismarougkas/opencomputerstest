return {
    ["tar"] = {["location"] = "/programs/tar.lua", ["save"] = "/bin/", ["name"] = "tar.lua",},
    ["transfer"] = {["location"] = "/programs/transfer.lua", ["save"] = "/bin/", ["name"] = "transfer.lua",},
    ["oppm"] = {["location"] = "/apt/programs/oppm/oppm.lua", ["save"] = "/bin/", ["name"] = "oppm.lua", ["dependencies"] = {"oppm_config", "oppm_opdata"}},
    ["oppm_config"] = {["location"] = "/apt/programs/oppm/oppm.cfg", ["save"] = "/etc/", ["name"] = "oppm.cfg", ["hide"] = true},
    ["oppm_opdata"] = {["location"] = "/apt/programs/oppm/opdata.svd", ["save"] = "/etc/", ["name"] = "opdata.svd", ["hide"] = true}
}

-- default values:
--   Version: 1.0
--   dependencies: {}
--   hide: false 
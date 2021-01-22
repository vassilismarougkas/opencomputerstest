return {
    ["tar"] = {["location"] = "/programs/tar.lua", ["save"] = "/bin/", ["name"] = "tar.lua", ["dependencies"] = {}},
    ["transfer"] = {["location"] = "/programs/transfer.lua", ["save"] = "/bin/", ["name"] = "transfer.lua", ["dependencies"] = {}},
    ["oppm"] = {["location"] = "/apt/programs/oppm/oppm.lua", ["save"] = "/bin/", ["name"] = "oppm.lua", ["dependencies"] = {"oppm_config", "oppm_opdata"}},
    ["oppm_config"] = {["location"] = "/apt/programs/oppm/oppm.cfg", ["save"] = "/etc/", ["name"] = "oppm.cfg", ["dependencies"] = {}},
    ["oppm_opdata"] = {["location"] = "/apt/programs/oppm/opdata.svd", ["save"] = "/etc/", ["name"] = "opdata.svd", ["dependencies"] = {}}
}
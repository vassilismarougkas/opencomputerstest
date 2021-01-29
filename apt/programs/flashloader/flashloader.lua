local filesystem = require("filesystem")

if not filesystem.exists("/data/flash") then
    filesystem.makeDirectory("/data/flash")
end


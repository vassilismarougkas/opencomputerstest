local timelib = {}
local fs = require("filesystem")

function timelib.getDate(format)
    if not fs.get("/").isReadOnly() then
        local time = io.open("/tmp/.time", "w")
        time:write()
        time:close()
        os.sleep(0.01)
        return os.date(format, fs.lastModified("/tmp/.time") / 1002.7)
    else
        return nil
    end
end

return timelib
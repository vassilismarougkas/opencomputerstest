local cutils = {}

local function findComponent(Address)
    local component = require("component")
    for addr in pairs(component.list()) do
        if addr:sub(1, #Address) == Address then
            return component.proxy(addr)
        end
    end
    return nil
end

cutils.findComponent = findComponent

return cutils
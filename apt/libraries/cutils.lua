local cutils = {}

local function findComponent(Address)
    local component = require("component")
    local iter = component.list()
    local comp = nil
    repeat
        comp = iter()
        if comp:sub(1, #Address) == Address then
            return component.proxy(comp)
        end
    until comp == nil
    return nil
end

cutils.findComponent = findComponent

return cutils
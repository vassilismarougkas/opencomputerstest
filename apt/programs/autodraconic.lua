-- Draconic Evolution Fusion automation for 1.12.2
local component = require("component")
local sides = require("sides")

local setups = {}
setups[1] = {
    enabled = true,
    transposer_id = "972a473c-d540-473d-8b57-c8d6462811c3",
    output_transposer_id = "284082c3-9479-4014-bdf4-c3f4677ee271",
    redstone_id = "508e4558-8d34-4ddd-8414-04908fa233e2",
    core_side = sides.up, -- chest that transfers to fusion core (from input transposer)
    infusers_side = sides.down, -- chest that transfers to the infusers (from input transposer)
    chest_side = sides.east, -- chest that's connected to the interface(s) (from input transposer)
    infuser_side = sides.east, -- side of the infusion core (from output transposer)
    output_side = sides.west, -- side of the final chest (from output transposer)
    redstone_side = sides.up -- side of the fusion core (from the redstone IO)
}
setups[2] = {
    enabled = true,
    transposer_id = "ad2dc53f-9ccc-412e-8f71-406a247f51fd",
    output_transposer_id = "5ad0b02c-4759-4091-a825-bd0df47d54f9",
    redstone_id = "5be8350c-11d6-4419-94c0-bbceb804c13a",
    core_side = sides.up, -- chest that transfers to fusion core (from input transposer)
    infusers_side = sides.down, -- chest that transfers to the infusers (from input transposer)
    chest_side = sides.west, -- chest that's connected to the interface(s) (from input transposer)
    infuser_side = sides.east, -- side of the infusion core (from output transposer)
    output_side = sides.west, -- side of the final chest (from output transposer)
    redstone_side = sides.up -- side of the fusion core (from the redstone IO)
}

-- redstone_component = nil
-- output_transposer_component = nil
-- transposer_component = nil,
-- crafting = false

local function configureSetup(setup)
    setup.transposer_component = component.proxy(setup.transposer_id)
    setup.redstone_component = component.proxy(setup.redstone_id)
    setup.output_transposer_component = component.proxy(setup.output_transposer_id)
    setup.crafting = false
end

local function preInit()
    for i=1, #setups do
        if setups[i].enabled then
            configureSetup(setups[i])
        end
    end
end

local function Init()

end

local function pulse(setup)
    setup.redstone_component.setOutput(setup.redstone_side, 15)
    os.sleep(0.05)
    setup.redstone_component.setOutput(setup.redstone_side, 0)
end

local function checkCrafting(setup)
    local x1 = setup.output_transposer_component.getStackInSlot(setup.infuser_side,1)
    local x2 = setup.output_transposer_component.getStackInSlot(setup.infuser_side,2)
    if (x1 == nil and x2 == nil) then
        local x3 = setup.transposer_component.getStackInSlot(setup.core_side, 1)
        if x3 == nil then
            local x1 = setup.output_transposer_component.getStackInSlot(setup.infuser_side,1)
            if x1 == nil then
                setup.crafting = false
            else 
                setup.crafting = true
                os.sleep(0.1)
            end
        else
            setup.crafting = true
            os.sleep(0.1)
        end
    elseif (x1 ~= nil and x2 == nil) then
        pulse(setup)
        setup.crafting = true
    elseif (x1 == nil and x2 ~= nil) then
        -- output_transposer_component
        setup.output_transposer_component.transferItem(setup.infuser_side, setup.output_side, 64, 2)
        setup.crafting = false
    else 
        setup.output_transposer_component.transferItem(setup.infuser_side, setup.output_side, 64, 2)
        pulse(setup)
        setup.crafting = true
    end
end

local function startCrafting(setup)
    local invsize = setup.transposer_component.getInventorySize(setup.chest_side)
    local craftsize = 0
    
    for i=1,invsize do
        if setup.transposer_component.getStackInSlot(setup.chest_side, i) == nil then
            craftsize = i-1
            break
        end
    end
    if (craftsize == 0) then
        return nil
    end
    setup.transposer_component.transferItem(setup.chest_side, setup.core_side, 64, 1)
    for i=2,craftsize do
        setup.transposer_component.transferItem(setup.chest_side, setup.infusers_side, 64, i)
    end
    setup.crafting = true
    os.sleep(0.1)
    pulse(setup)
end

local function runSetup(setup)
    if setup.crafting then
        checkCrafting(setup)
    else
        startCrafting(setup)
    end
end

local function loop()
    for i=1,#setups do
        if (setups[i].enabled) then
            runSetup(setups[i])
            os.sleep(0.1)
        end
    end
end

local function Start()
    while true do
        loop()
    end
end

preInit()
Init()
Start()
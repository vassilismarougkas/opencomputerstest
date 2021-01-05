local redstone = component.proxy(component.list("redstone")())
local piston = component.proxy(component.list("piston")())
local modem = component.proxy(component.list("modem")())

--while true do
--    computer.pullSignal(0.5)
--    if redstone.getInput(4) > 0 then
--        piston.pull(3)
--    end
--end
modem.open(23)

while true do
    local signal = {computer.pullSignal(1)}
    if (signal[1] == "redstone_changed") then
        if (redstone.getInput(5) == 0) then
            redstone.setOutput(1, 15)
        else 
            redstone.setOutput(1, 0)
        end
    end
    if (signal[1] == "modem_message") then
        if (signal[6] == "00001" and signal[4] == 23) then
            redstone.setOutput(1, 0)
        elseif signal[6] == "00002" and signal[4] == 23 then
            redstone.setOutput(1, 15)
        end
    end
end
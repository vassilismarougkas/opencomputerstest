local formatter = {}
formatter.ptable={
    [1] = "f", [2] = "p", [3] = "n",[4] = "μ",
    [5] = "m", [6] = "",[7] = "k", [8] = "M",
    [9] = "G", [10] = "T",[11] = "P", [12] = "E",
    [13] = "Z", [14] = "Y" }

function formatter.formatNumber(number, accuracy)
    number = tonumber(number)
    accuracy = accuracy or 1
    local el = math.floor(math.log(math.abs(number), 1000))
    local n = math.floor(math.abs( number ) / math.pow(10, (3*el - accuracy)))/math.pow(10, accuracy)
    local fstring = nil
    if (number >= 0) then
        fstring = tostring(n).." "..formatter.ptable[(el+6)]
    else 
        fstring = "-"..tostring(n).." "..formatter.ptable[(el+6)]
    end
    return fstring
end

return formatter
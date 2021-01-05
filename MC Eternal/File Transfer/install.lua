local shell = require("shell")
local term = require("term")
local component = require("component")

if (component.internet == nil) then
    print("No Internet Card Found!")
    print("Please install one and try again!")
else
    term.clear()
    term.setCursor(1,1)
    print("Downloading Transfer Program from Pastebin!")
    shell.execute("pastebin get wzpHEiyT //bin/transfer.lua")
    print("Downloading Remote File Transfer Protocol Library from Pastebin!")
    shell.execute("pastebin get AaSLzhwh //lib/rftp.lua")
    print("Installation Complete!")
    print("A system reboot is recommended!")
end
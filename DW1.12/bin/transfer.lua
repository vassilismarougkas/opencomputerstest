local filesystem = require("filesystem")
local term = require("term")
local shell = require("shell")
local list = nil
local ins = nil
local out = nil
local choise = nil
local dl = nil
local drives = {}
local c1 = nil
local c2 = nil
 
function termClear()
  term.clear()
  term.setCursor(1,1)
end
 
function fold()
  termClear()
  print("Enter the location of the folder you want to transfer")
  ins = io.read()
  print("Enter the location of the folder you want to extract")
  out = io.read()
  loop()
end
 
function loop()
  list = filesystem.list(ins)
  termClear()
  while true do
    s = list()
    if s==nil then
      break
    end
  shell.execute("copy -r "..ins.."/"..s.." "..out)
  print(s.." done!")
  end
  print("Transfer complete!")
end
 
function driv()
  dl = filesystem.list("//mnt")
  k = 0
  while true do
	  s = dl()
	  if s == nil then
		break
	  end
	  k = k + 1
	  drives[k] = s
  end
  termClear()
  for key, amount in pairs(drives) do
    print(key..". "..amount)
  end
  term.write("from: ")
  c1 = io.read()
  term.write("to: ")
  c2 = io.read()
  ins = "//mnt/"..drives[tonumber(c1)]
  out = "//mnt/"..drives[tonumber(c2)]
  loop()
end
 
function start()
  termClear()
  print("1. drives")
  print("2. folders")
  term.write("choise: ")
  choise = io.read()
  choise = tonumber(choise)
  if choise == 1 then
    driv()
  elseif choise == 2 then
    fold()
  end
end
 
 
 
start()
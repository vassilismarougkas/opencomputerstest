local filesystem = require("filesystem")
local term = require("term")
local shell = require("shell")

local function termClear()
  term.clear()
  term.setCursor(1,1)
end

local functions = {}

local function nextLine()
  local x,y = term.getCursor()
  term.setCursor(1,y+1)
end

local function interface()
  termClear()
  term.write("Choose Function: ")
  local tx, ty = term.getCursor()
  nextLine()
  term.write("1. Clone Drive")
  nextLine()
  term.write("2. Copy Folder")
  nextLine()
  term.write("3. Remote File Transfer")
  term.setCursor(tx,ty)
  local choice = tonumber(io.read())
  if (choice > 3 or choice < 1) then
    interface()
    return nil
  end
  functions[choice]()
end

local function copy(inF, outF)
  local filelist = filesystem.list(inF)
  termClear()
  term.write("Starting Transfer!")
  nextLine()
  local tf = filelist()
  while tf ~= nil do
    shell.execute("copy -r "..inF.."/"..tf.." "..outF)
    print("Transfer of /"..tf.." folder complete!")
    tf = filelist()
  end
  print("Transfer complete!")
end

local function copyFolder()
  termClear()
  print("Folder Clone Protocol")
  print("Enter the location of the folder you want to transfer")
  local inF = io.read()
  print("Enter the location of the folder you want to extract")
  local outF = io.read()
  copy(inF,outF)
end

local function cloneDrive()
  local dl = filesystem.list("//mnt")
  local drives = {}
  local dr = dl()
  termClear()
  repeat
    table.insert(drives, dr)
    dr = dl()
  until dr == nil
  for key, amount in pairs(drives) do
    print(key..". "..amount)
  end
  term.write("from: ")
  local c1 = io.read()
  term.write("to: ")
  local c2 = io.read()
  copy("//mnt/"..drives[tonumber(c1)],"//mnt/"..drives[tonumber(c2)])
end

functions[1] = cloneDrive
functions[2] = copyFolder
functions[3] = require("rftp")

interface()
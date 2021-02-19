local filesystem = require("filesystem")
local term = require("term")
local shell = require("shell")

local component = require("component")

local function termClear()
  term.clear()
  term.setCursor(1,1)
end

local function nextLine()
  local x,y = term.getCursor()
  term.setCursor(1,y+1)
end

local function copyfolder(sf,tf)
  local list = filesystem.list(sf)
  termClear()
  for s in list do
      shell.execute("copy -r "..sf.."/"..s.." "..tf)
  end
  print("Transfer complete!")
end

local function CloneDrive()
  termClear()
  term.write("Select Source Drive:   ")
  local x1,y1 = term.getCursor()
  x1 = x1-2
  term.write("Select Target Drive: ")
  local x2,y2 = term.getCursor()

  local drives = {}
  local dl = filesystem.list("//mnt")
  local k = 1

  for s in dl do
      nextLine()
      drives[k] = s
      term.write(tostring(k)..". "..s)
      k = k + 1
  end

  term.setCursor(x1,y1)
  local d1 = tonumber(io.read())
  term.setCursor(x2,y2)
  local d2 = tonumber(io.read())
  
  if (math.abs(d1)+math.abs(d2) <= 0 or math.abs(d1) + math.abs(d2) >= (2*#drives) or d1 <= 0 or d2 <= 0) then
      return nil
  end

  copyfolder("//mnt/"..drives[d1], "//mnt/"..drives[d2])
  return nil
end

local function CopyFolder()

  termClear()
  term.write("Source Folder: ")
  local inf = io.read()
  nextLine()
  print("Target Folder: ")
  local outf = io.read()
  copyfolder(inf, outf)

  return nil
end

local function interface()

    termClear()
    term.write("Select function: ")
    local x,y = term.getCursor()
    term.setCursor(1,2)
    term.write("1. Clone Drive")
    term.setCursor(1,3)
    term.write("2. Copy Folder")

    term.setCursor(x,y)
    local choice = tonumber(io.read())

    if not (choice >= 1 and choice <= 3) then
        interface()
        return nil
    end

    if (choice == 1) then
        CloneDrive()
    elseif (choice == 2) then
        CopyFolder()
    end
    return nil

end

interface()

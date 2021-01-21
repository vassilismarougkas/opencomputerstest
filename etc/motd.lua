local filesystem = require("filesystem")
filesystem.remove("/temp")
filesystem.makeDirectory("/temp")
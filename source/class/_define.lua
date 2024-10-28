local class = {}

class.jellyfish = require("source.class.jellyfish")--require("source.class.jellyfish")
  class.jellyfishStill = class.jellyfish
  class.jellyfishMove = class.jellyfish
class.wall = require("source.class.wall")
class.player = require("source.class.player")

return class
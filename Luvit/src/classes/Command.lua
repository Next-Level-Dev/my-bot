local Command = {}
Command.__index = Command

function Command:new(Name, Callback)
   local self = {
      Name = Name,
      Callback = Callback
   }

   setmetatable(self, Command)

   return self
end

function Command:Run(message, args)
   self.Callback(message, table.unpack(args))
end

return Command
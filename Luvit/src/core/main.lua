local Discordia = require("Discordia")
local Client = Discordia.Client()
local CommandHandler = require("../dependencies/CommandHandler.lua")
local Commands = require("../dependencies/Commands.lua")
local CommandClass = require("../classes/Command.lua")

function sleep(n)
   if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
end

local function initializeCommands()
   for key, callback in pairs(Commands) do
      CommandHandler.AddCommand(CommandClass:new(key, function(message, ...)
         callback({
            CommandHandler = CommandHandler,
            Message = message,
            Args = {...}
         })
      end))
   end
end

initializeCommands()

Client:on("ready", function()
   print("the bot is ready!")
end)

Client:on("messageCreate", function(message)
   local prefix = "!"

   if message.author.bot then
      return
   else
      CommandHandler.Parse(message, prefix)
   end
end)

Client:run("Bot MTI4Njc1NTIxNDc5MTE0NzU4MA.GU5TV1.Nn7iZn4VHY6dgg_Ud9AECgjFw_cPcNdMeujbBQ")
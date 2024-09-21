local Commands = {}
local Discordia = require("Discordia")

function sleep(n)
   if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
end

function Commands.Help(context)
   local message = context.Message
   
   message.channel:send{
      embed = {
         title = "Help",
         description = "list of all the usefull commands:",
         fields = {
            {name = "General Commands", value = "`!Help`, `!Ping`, `!Echo {message}`, `!Avatar {user}`", inline = false},
            {name = "Fun Commands", value = "`!Embed`", inline = false}
         }
      }
   }
end

function Commands.Ping(context)
   local message = context.Message

   message:reply("Pong!")
end

function Commands.Echo(context)
   local args = context.Args
   local message = context.Message

   local finalstring = ""
   for i,v in pairs(args) do
      finalstring = finalstring .. " " .. v
   end

   message:reply(finalstring)
end

function Commands.Embed(context)
   local message = context.Message

   local botmsg = message.channel:send{
      embed = {
         title = "Test Embed",
         fields = {
           {name = "Bot", value = "im a dumb ass bot", inline = false},
           {name = "hello", value = "yappathron", inline = false},
         },
         color = Discordia.Color.fromRGB(255, 0, 43).value
       }
   }
end

function Commands.Avatar(context)
   local message = context.Message
   local mentioneduser = message.mentionedUsers.first
   
   message.channel:send{
      embed = {
         title = mentioneduser.name .. "'s Avatar",
         image = {url = mentioneduser.avatarURL},
         color = Discordia.Color.fromRGB(71, 214, 4).value
      }
   }

end

return Commands
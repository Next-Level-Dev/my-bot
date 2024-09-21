local CommandHandler = {Commands = {}}

local function splitMessage(string)
   local seperator = "%s"
   local words = {}

   for str in string.gmatch(string, "([^"..seperator.."]+)") do
      table.insert(words, str)
   end

   return words
end

function CommandHandler.AddCommand(commandObject)
   CommandHandler.Commands[commandObject.Name:lower()] = commandObject
end

function CommandHandler.Parse(message, validPrefix)
   local content = message.content
   local splitMessage = splitMessage(content)

   if not splitMessage or not splitMessage[1] then
      return
   end

   local prefix = content:sub(1, #validPrefix)
   local command = CommandHandler.Commands[splitMessage[1]:sub(#validPrefix+1):lower()]

   local isCommand = prefix == validPrefix and command ~= nil

   if not isCommand then
      return
   end

   local arguments = {}

   for i, v in pairs(splitMessage) do
      if i ~= 1 then
         table.insert(arguments, v)
      end
   end

   command:Run(message, arguments)
end

return CommandHandler
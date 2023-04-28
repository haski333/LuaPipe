# LuaPipe
### LuaPipe is a roblox module that makes communicating between the server and clients much easier

## Client Example
```lua
local LuaPipe = require(...)

local RedeemCodePipe = LuaPipe:GetPipe("RedeemCode") -- Gets a pipe created by the server by a name

Redeem.MouseButton1Click:Connect(function() -- Event when reedem button is clicked
    RedeemCodePipe:Send(CodeTextBox.Text) --Calls pipe and sends arguments to the receiver
end)
```
## Server Example
```lua
local LuaPipe = require(...)

local CashCodes = {
    ["LuckyCode"] = 100,
    ["SecretCode"] = 100
} -- A table of codes that players can reedem

local RedeemCodePipe = LuaPipe:GetPipe("RedeemCode") -- Creates pipe for communication

RedeemCodePipe(function(Player, Code) -- Call the pipe like a function to start receiving sent data
    local Cash = CashCodes[Code]
    if not Cash then -- Code sent doesn't exist
	print("Code is incorrect!")
    end
	
    print("Code is correct!")
    Player.Cash.Value += Cash -- Increases cash by the number of cash from the code
end)
```

### To destroy a pipe, use the Destroy function
```lua
Pipe:Destroy()
```


<h1 align="center">LuaPipe</h1>

### LuaPipe is a roblox module that makes communicating between the server and clients easier
## [Raw Module](https://github.com/haski333/LuaPipe/blob/main/LuaPipe.lua)

## Client Example
```lua
local LuaPipe = require(...)

local RedeemCodePipe = LuaPipe:GetPipe("RedeemCode") -- Gets a pipe created by the server by a name

Redeem.MouseButton1Click:Connect(function() -- Event when reedem button is clicked
    RedeemCodePipe:Call(CodeTextBox.Text) --Calls pipe and sends arguments to the receiver
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
### By default, on the server, LuaPipe takes care of calling one `Client` or `All clients`

## To only call one client, make the first argument the target `Client/Player`
```lua
local JumpscarePipe = LuaPipe:GetPipe("Jumpscare")

local JumpscareData = {
    ["Duration"] = 1
}
JumpscarePipe:Call(Player, JumpscareData) --Jumpscares target player
```
## Else, calling all clients will just be passing no `Client/Player`
```lua
local JumpscarePlayerPipe = LuaPipe:GetPipe("Jumpscare") -- Creates a jumpscare pipe

local JumpscareData = {
	["Duration"] = 1
}
JumpscarePlayerPipe:Call(JumpscareData) --Jumpscares all players
```
### To destroy a pipe, use the `Destroy` function
```lua
local Pipe = LuaPipe:GetPipe("TestPipe")
Pipe:Destroy() -- Pipe will be destroyed and the server/client will not longer receive data
```
### Use the `IsAvailable` function to check if pipe is destroyed/hasn't been initialized
```lua
local Pipe = LuaPipe:GetPipe("TestPipe")
print(Pipe:IsAvailable()) -- true

Pipe:Destroy()
print(Pipe:IsAvailable()) -- false
```


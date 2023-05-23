<h1 align="center">LuaPipe</h1>

<h2 align="center">LuaPipe is a roblox module that makes communicating between the server and clients easier</h2>

## [LuaPipe](https://github.com/haski333/LuaPipe/blob/main/LuaPipe.lua) (Installation)

## Client Example
```lua
local LuaPipe = require(...)

local RedeemCodePipe = LuaPipe:GetPipe("RedeemCode") -- Gets a pipe created from the server by a name

Redeem.MouseButton1Click:Connect(function() -- Connects a function when the reedem button is clicked
    RedeemCodePipe:Dispatch(CodeTextBox.Text) -- Dispatches pipe data and sends parameters to the receiver
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

RedeemCodePipe(function(Player, Code) -- Call the pipe to start listening and set your callback
    local Cash = CashCodes[Code]
    if not Cash then -- Code sent doesn't exist
	print("Code is incorrect!")
	return
    end
	
    print("Code is correct!")
    Player.Cash.Value += Cash -- Increases cash by the number of cash from the code
end)
```
## On the server, LuaPipe takes care of calling one **`Client`** or `All clients`

- To only call one client, make the first parameter the target `Client/Player`
```lua
local JumpscarePipe = LuaPipe:GetPipe("Jumpscare")

local JumpscareData = {
    ["Duration"] = 1
}
JumpscarePipe:Dispatch(Player, JumpscareData) -- Jumpscares target player
```
- Else, calling all clients will just be passing no `Client/Player`
```lua
local JumpscarePipe = LuaPipe:GetPipe("Jumpscare")

local JumpscareData = {
    ["Duration"] = 1
}
JumpscarePipe:Dispatch(JumpscareData) -- Jumpscares all clients/players
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


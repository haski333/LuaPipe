# LuaPipe
### LuaPipe is a roblox module that makes communicating between the server and clients much easier

## Client Example
```lua
local LuaPipe = require(...)

local RedeemCodePipe = LuaPipe:GetPipe("RedeemCode")

Redeem.MouseButton1Click:Connect(function()
	RedeemCodePipe:Call(CodeTextBox.Text)
end)

```

# **Notes**
### Getting the whole pythonized table's content will return **_nil_**
## Example
```lua
local Foods = Pythonize({"Hamburger", "Salad", "Salmon"})
print(Foods) -- {}
```

### To fix this we are gonna need to call the table like a **_function_**
## Example
```lua
local Foods = Pythonize({"Hamburger", "Salad", "Salmon"})
print(Foods()) -- {"Hamburger", "Salad", "Salmon"}
```


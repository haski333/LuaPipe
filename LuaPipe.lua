local LuaPipe = {}

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local RemotesLocation = Instance.new("Folder")
RemotesLocation.Name = "__LuaPipeRemotes__"
RemotesLocation.Parent = ReplicatedStorage

LuaPipe.Pipe = {
	["Name"] = nil,
	["ConectedRemote"] = nil,
	["ConnectedEventFunction"] = nil,
	["CommunicationType"] = "RemoteEvent",
	["Location"] = RemotesLocation,
} -- Pipe

LuaPipe.Pipe.__index = LuaPipe.Pipe

LuaPipe.Pipe.__call = function(self, ConnectedFunction)
	self.ConnectedEventFunction = 
		self.ConnectedRemote.OnServerEvent:Connect(function(Player, ...)

			ConnectedFunction(table.unpack({Player, ...}))
		end)

end

LuaPipe.Pipes = {} -- Pipes table

function LuaPipe:GetPipe(PipeName: string) -- Gets/Creates pipe with specific name
	if RunService:IsServer() then -- Function called by the server
		if self.Pipes[PipeName] then return end --Pipe already exists

		local PipeRemote = Instance.new(self.Pipe.CommunicationType)
		PipeRemote.Name = PipeName
		PipeRemote.Parent = self.Pipe.Location

		local Pipe = {}
		setmetatable(Pipe, self.Pipe)

		Pipe.ConnectedRemote = PipeRemote
		self.Pipes[PipeName] = Pipe

		return Pipe


	else -- Function called by a client
		repeat task.wait() until LuaPipe.Pipe.Location:FindFirstChild(PipeName) --Repeat getting communication remote
		local ConnectedRemote = LuaPipe.Pipe.Location:FindFirstChild(PipeName)
		local Pipe = {}
		setmetatable(Pipe, self.Pipe)

		Pipe.Name = PipeName
		Pipe.ConnectedRemote = ConnectedRemote
		return Pipe
	end
end

function LuaPipe.Pipe:Dispatch(...)
	if RunService:IsServer() then -- Called by server
		local Args = {...}
		if typeof(Args[1]) == "Instance" and Args[1]:IsA("Player") then
			local Player = Args[1]
			table.remove(Args, 1) -- Removes Player
			self.ConnectedRemote:FireClient(Player, Args)
			return
		end
		self.ConnectedRemote:FireAllClients(...)
	else -- Called by client
		self.ConnectedRemote:FireServer(...)
	end
end

function LuaPipe.Pipe:Destroy()
	if RunService:IsServer() then -- Called by server
		self.ConnectedRemote:Destroy()
		self.ConnectedEventFunction:Disconnect()

		self.ConnectedRemote = nil
		self.ConnectedEventFunction = nil

		LuaPipe.Pipes[self.Name] = nil
	end
end

function LuaPipe.Pipe:IsAvailable()
	if self.ConnectedRemmote.Parent == nil and self.ConnectedEventFunction == nil then
		return true
	end
	return false
end

return LuaPipe

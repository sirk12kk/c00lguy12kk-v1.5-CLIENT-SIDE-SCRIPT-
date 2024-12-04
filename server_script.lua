-- Server Script: Place this in ServerScriptService
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Create Remote Events
local RemoteEvents = {
    GiveBazooka = Instance.new("RemoteEvent"),
    ExplodePlayer = Instance.new("RemoteEvent"),
    SpawnPart = Instance.new("RemoteEvent"),
    RainbowCharacter = Instance.new("RemoteEvent"),
    TeleportPlayer = Instance.new("RemoteEvent")
}

-- Configure and Parent Events
for name, event in pairs(RemoteEvents) do
    event.Name = name
    event.Parent = ReplicatedStorage
end

-- Event Handlers
RemoteEvents.GiveBazooka.OnServerEvent:Connect(function(player)
    -- Give the player a Rocket Launcher
    local tool = Instance.new("Tool")
    tool.Name = "Rocket Launcher"
    tool.RequiresHandle = true

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.BrickColor = BrickColor.new("Bright red")
    handle.Parent = tool
    tool.Parent = player.Backpack
end)

RemoteEvents.ExplodePlayer.OnServerEvent:Connect(function(player, targetPlayer)
    -- Explode a specific player
    if targetPlayer and targetPlayer.Character then
        local explosion = Instance.new("Explosion")
        explosion.Position = targetPlayer.Character.HumanoidRootPart.Position
        explosion.BlastRadius = 10
        explosion.BlastPressure = 50000
        explosion.Parent = workspace
    end
end)

RemoteEvents.SpawnPart.OnServerEvent:Connect(function(player, position)
    -- Spawn a part at the specified position
    local part = Instance.new("Part")
    part.Size = Vector3.new(5, 5, 5)
    part.Position = position
    part.BrickColor = BrickColor.Random()
    part.Anchored = true
    part.Parent = workspace
end)

RemoteEvents.RainbowCharacter.OnServerEvent:Connect(function(player)
    -- Make the player's character a rainbow for everyone
    local character = player.Character
    if character then
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                spawn(function()
                    while wait(0.1) do
                        v.BrickColor = BrickColor.Random()
                    end
                end)
            end
        end
    end
end)

RemoteEvents.TeleportPlayer.OnServerEvent:Connect(function(player, targetPlayer)
    -- Teleport the player to another player
    if targetPlayer and targetPlayer.Character then
        player.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
    end
end)
